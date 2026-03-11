#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"
CONTAINER_DOTFILES="/root/.dotfiles"
STUDENT_DOTFILES="/home/student/.dotfiles"

usage() {
	local prog=${0##*/}
	cat <<-EOF
	Usage: $prog <os> <scenario>

	Test the dotfiles setup script in a container.

	OS:
	    fedora          Fedora 42 (dnf)
	    ubuntu          Ubuntu 24.04 (apt, with sudo — home)
	    ubuntu-nosudo   Ubuntu 24.04 (brew, no sudo — 42 school)
	    mac             Homebrew on Linux — tests the brew code path

	Scenarios:
	    empty        No deps pre-installed
	    all-deps     All deps pre-installed (setup should skip installs)
	    partial-deps Only git + zsh pre-installed
	    ssh          Mount real SSH keys from host
	EOF
}

get_os_config() {
	case "$1" in
		fedora)
			IMAGE="fedora:42"
			ALL_DEPS="dnf install -y openssh git zsh neovim fzf ripgrep clang-tools-extra &&"
			PARTIAL_DEPS="dnf install -y git zsh &&"
			;;
		ubuntu)
			IMAGE="ubuntu:24.04"
			ALL_DEPS="apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo openssh-client git zsh neovim fzf ripgrep clangd tmux procps &&"
			PARTIAL_DEPS="apt-get update -q && apt-get install -y sudo git zsh &&"
			;;
		ubuntu-nosudo)
			IMAGE="ubuntu:24.04"
			ALL_DEPS=""
			PARTIAL_DEPS=""
			;;
		mac)
			IMAGE="ghcr.io/homebrew/brew"
			ALL_DEPS="brew install openssh git zsh neovim fzf ripgrep llvm tmux &&"
			PARTIAL_DEPS="brew install git zsh &&"
			;;
		*)
			echo "Unknown OS: $1" >&2
			usage >&2
			exit 1
			;;
	esac
}

run_container() {
	local pre_install="${1:-}"
	shift || true
	sudo docker run -it --rm \
		-v "$DOTFILES_DIR:$CONTAINER_DOTFILES:z" \
		"$@" \
		"$IMAGE" bash -c "${pre_install} bash $CONTAINER_DOTFILES/scripts/setup/setup.sh && exec bash"
}

run_container_nosudo() {
	local pre_install="${1:-}"
	shift || true

	local setup_cmd
	setup_cmd=$(cat <<-'CMD'
		apt-get update -q &&
		DEBIAN_FRONTEND=noninteractive apt-get install -y curl git build-essential &&
		useradd -m -s /bin/bash student &&
		cp -r /root/.dotfiles /home/student/.dotfiles &&
		chown -R student:student /home/student/.dotfiles &&
		mkdir -p /home/linuxbrew/.linuxbrew &&
		chown -R student:student /home/linuxbrew &&
		su - student -c "
			NONINTERACTIVE=1 /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" &&
			eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\" &&
			STUDENT_PRE_INSTALL
			bash /home/student/.dotfiles/scripts/setup/setup.sh &&
			exec bash
		"
	CMD
	)

	setup_cmd="${setup_cmd/STUDENT_PRE_INSTALL/$pre_install}"

	sudo docker run -it --rm \
		-v "$DOTFILES_DIR:$CONTAINER_DOTFILES:z" \
		"$@" \
		"$IMAGE" bash -c "$setup_cmd"
}

OS="${1:-}"
SCENARIO="${2:-}"

if [[ -z "$OS" || -z "$SCENARIO" ]]; then
	usage
	exit 1
fi

get_os_config "$OS"

if [[ "$OS" == "ubuntu-nosudo" ]]; then
	case "$SCENARIO" in
		empty)
			run_container_nosudo ;;
		all-deps)
			run_container_nosudo "brew install openssh git zsh neovim fzf ripgrep llvm tmux &&" ;;
		partial-deps)
			run_container_nosudo "brew install git zsh &&" ;;
		ssh)
			run_container_nosudo "" -v "$HOME/.ssh:/home/student/.ssh:z" ;;
		*)
			echo "Unknown scenario: $SCENARIO" >&2
			usage >&2
			exit 1
			;;
	esac
else
	case "$SCENARIO" in
		empty)
			run_container ;;
		all-deps)
			run_container "$ALL_DEPS" ;;
		partial-deps)
			run_container "$PARTIAL_DEPS" ;;
		ssh)
			run_container "" -v "$HOME/.ssh:/root/.ssh:z" ;;
		*)
			echo "Unknown scenario: $SCENARIO" >&2
			usage >&2
			exit 1
			;;
	esac
fi
