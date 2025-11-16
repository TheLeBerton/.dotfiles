SSH_ENV="$HOME/.ssh/agent_env"

start_agent() {
    echo "Starting ssh-agent..."
	ssh-agent -s | grep -v '^echo' > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null && echo "SSH key added."
}

if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    ssh-add -l > /dev/null 2>&1 || start_agent
else
    start_agent
fi

echo "Exiting zprofile"

