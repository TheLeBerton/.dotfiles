if [ -z "$SSH_AUTH_SOCK" ] || ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
    export SSH_AUTH_SOCK
    sleep 2
fi

if ! ssh-add -l | grep -q "id_ed25519"; then
    ssh-add ~/.ssh/id_ed25519
fi

DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles directory not found. Please clone the repository."
else
    "$HOME/.dotfiles/scripts/pull_all"
fi

