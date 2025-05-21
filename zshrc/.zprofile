if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

if [ -z "$SSH_AUTH_SOCK" ] && [ -S "$HOME/Library/Containers/com.openssh.ssh-agent/Data/ssh-agent.sock" ]; then
    export SSH_AUTH_SOCK="$HOME/Library/Containers/com.openssh.ssh-agent/Data/ssh-agent.sock"
fi

ssh-add -l > /dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519 2>/dev/null
