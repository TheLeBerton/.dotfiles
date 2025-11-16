#!/bin/bash

# Dotfiles Update Script
# Safely updates dotfiles from repository and applies changes

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

success() { echo -e "${GREEN}✅${NC} $1"; }
warning() { echo -e "${YELLOW}⚠️${NC} $1"; }
error() { echo -e "${RED}❌${NC} $1"; }
info() { echo -e "${BLUE}ℹ️${NC} $1"; }

DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backups"

show_help() {
    cat << EOF
Dotfiles Update Script

Usage: $0 [OPTIONS]

Options:
    --check         Check for updates without applying
    --backup        Create backup before updating
    --force         Force update even with uncommitted changes
    --help          Show this help message

Examples:
    $0              # Check and update if clean
    $0 --backup     # Create backup before updating
    $0 --force      # Force update ignoring local changes
EOF
}

check_repository() {
    info "Checking dotfiles repository..."

    if [[ ! -d "$DOTFILES" ]]; then
        error "Dotfiles directory not found: $DOTFILES"
        exit 1
    fi

    cd "$DOTFILES"

    if [[ ! -d ".git" ]]; then
        error "Not a git repository: $DOTFILES"
        exit 1
    fi

    # Check if we have a remote
    if ! git remote get-url origin &>/dev/null; then
        warning "No remote repository configured"
        return 1
    fi

    success "Repository found and configured"
    return 0
}

check_for_updates() {
    info "Checking for updates..."

    cd "$DOTFILES"

    # Fetch latest changes
    if ! git fetch origin main 2>/dev/null; then
        warning "Failed to fetch updates (network issue?)"
        return 1
    fi

    # Check if we're behind
    local behind=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
    local ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")

    if [[ "$behind" -gt 0 ]]; then
        info "Updates available: $behind commit(s) behind remote"
        if [[ "$ahead" -gt 0 ]]; then
            warning "You have $ahead uncommitted changes that will need merging"
        fi
        return 0
    else
        success "Already up to date!"
        return 1
    fi
}

check_working_directory() {
    cd "$DOTFILES"

    # Check for uncommitted changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        warning "You have uncommitted changes:"
        git status --porcelain
        return 1
    fi

    # Check for untracked files
    local untracked=$(git ls-files --others --exclude-standard)
    if [[ -n "$untracked" ]]; then
        warning "You have untracked files:"
        echo "$untracked"
        return 1
    fi

    return 0
}

create_backup() {
    info "Creating backup of current configuration..."

    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_path="$BACKUP_DIR/backup_$timestamp"

    mkdir -p "$backup_path"

    # Backup key config files
    local files_to_backup=(
        "$HOME/.zshrc"
        "$HOME/.zprofile"
        "$HOME/.tmux.conf"
        "$HOME/.gitconfig"
        "$HOME/.config/nvim"
        "$HOME/.config/kitty"
    )

    for file in "${files_to_backup[@]}"; do
        if [[ -e "$file" ]]; then
            local dest="$backup_path/$(basename "$file")"
            if [[ -d "$file" ]]; then
                cp -r "$file" "$dest" 2>/dev/null || true
            else
                cp "$file" "$dest" 2>/dev/null || true
            fi
        fi
    done

    # Also backup current dotfiles state
    cd "$DOTFILES"
    git log -1 --oneline > "$backup_path/git_state.txt"
    git status > "$backup_path/git_status.txt"

    success "Backup created: $backup_path"
    echo "$backup_path" > "$HOME/.last_dotfiles_backup"
}

apply_updates() {
    info "Applying updates..."

    cd "$DOTFILES"

    # Pull changes
    if git pull origin main; then
        success "Updates applied successfully"
    else
        error "Failed to apply updates"
        return 1
    fi

    # Reload shell configuration if zsh is running
    if [[ -n "$ZSH_VERSION" ]]; then
        info "Reloading shell configuration..."
        source "$HOME/.zshrc" || warning "Failed to reload shell config"
    fi

    return 0
}

post_update_health_check() {
    info "Running post-update health check..."

    if command -v "$DOTFILES/scripts/utils/doctor.sh" &>/dev/null; then
        "$DOTFILES/scripts/utils/doctor.sh" | grep -E "(✅|❌|⚠️)" | head -10
    else
        # Basic health check
        if [[ -L "$HOME/.zshrc" && -L "$HOME/.gitconfig" ]]; then
            success "Basic symlinks are intact"
        else
            warning "Some symlinks may be broken"
        fi
    fi
}

main() {
    echo -e "${BLUE}📦 Dotfiles Update Manager${NC}\n"

    local check_only=false
    local create_backup_flag=false
    local force_update=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --check)
                check_only=true
                shift
                ;;
            --backup)
                create_backup_flag=true
                shift
                ;;
            --force)
                force_update=true
                shift
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done

    # Check repository
    if ! check_repository; then
        exit 1
    fi

    # Check for updates
    if ! check_for_updates; then
        exit 0  # Already up to date
    fi

    if [[ "$check_only" == true ]]; then
        info "Use '$0' to apply updates"
        exit 0
    fi

    # Check working directory
    if ! check_working_directory && [[ "$force_update" != true ]]; then
        error "Working directory is not clean. Use --force to override or commit your changes first"
        exit 1
    fi

    # Create backup if requested
    if [[ "$create_backup_flag" == true ]]; then
        create_backup
    fi

    # Apply updates
    if apply_updates; then
        post_update_health_check
        success "Dotfiles updated successfully! 🎉"

        if [[ -f "$HOME/.last_dotfiles_backup" ]]; then
            local backup_path=$(cat "$HOME/.last_dotfiles_backup")
            info "Backup available at: $backup_path"
        fi
    else
        exit 1
    fi
}

main "$@"