#!/bin/bash

# Dotfiles Health Check & Diagnostics
# Diagnoses potential issues with dotfiles configuration

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
ISSUES=0

check_dotfiles_structure() {
    echo -e "\n${BLUE}=== Dotfiles Structure ===${NC}"

    if [[ -d "$DOTFILES" ]]; then
        success "Dotfiles directory exists: $DOTFILES"
    else
        error "Dotfiles directory not found: $DOTFILES"
        ((ISSUES++))
        return
    fi

    local required_dirs=("shell/zsh" "terminal/tmux" "editors/nvim" "dev/git" "scripts")
    for dir in "${required_dirs[@]}"; do
        if [[ -d "$DOTFILES/$dir" ]]; then
            success "$dir/ directory exists"
        else
            error "Missing directory: $dir/"
            ((ISSUES++))
        fi
    done
}

check_symlinks() {
    echo -e "\n${BLUE}=== Symlink Status ===${NC}"

    local links=(
        "$HOME/.zshrc:$DOTFILES/shell/zsh/.zshrc"
        "$HOME/.zprofile:$DOTFILES/shell/zsh/.zprofile"
        "$HOME/.tmux.conf:$DOTFILES/terminal/tmux/.tmux.conf"
        "$HOME/.gitconfig:$DOTFILES/dev/git/config"
        "$HOME/.config/nvim:$DOTFILES/editors/nvim"
        "$HOME/.config/kitty:$DOTFILES/terminal/kitty"
    )

    for link_pair in "${links[@]}"; do
        local link="${link_pair%:*}"
        local target="${link_pair#*:}"
        local name=$(basename "$link")

        if [[ -L "$link" ]]; then
            local actual_target=$(readlink "$link")
            if [[ "$actual_target" == "$target" ]]; then
                success "$name → correctly linked"
            else
                warning "$name → points to wrong target: $actual_target"
                ((ISSUES++))
            fi
        elif [[ -e "$link" ]]; then
            warning "$name exists but is not a symlink"
            ((ISSUES++))
        else
            info "$name not found (may be optional)"
        fi
    done
}

check_shell_config() {
    echo -e "\n${BLUE}=== Shell Configuration ===${NC}"

    if [[ "$SHELL" == *"zsh"* ]]; then
        success "Default shell is zsh"
    else
        warning "Default shell is not zsh: $SHELL"
    fi

    # Check if zsh modules load properly
    if zsh -c "source ~/.zshrc && echo 'ZSH config loads successfully'" &>/dev/null; then
        success "Zsh configuration loads without errors"
    else
        error "Zsh configuration has syntax errors"
        ((ISSUES++))
    fi

    # Check environment detection
    local env_vars=$(zsh -c "source ~/.zshrc && echo OS=\$OS IS_42=\$IS_42" 2>/dev/null)
    if [[ -n "$env_vars" ]]; then
        success "Environment detection working: $env_vars"
    else
        warning "Environment detection may not be working"
    fi
}

check_tools() {
    echo -e "\n${BLUE}=== Required Tools ===${NC}"

    local tools=("git" "curl" "wget" "zsh")
    for tool in "${tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            success "$tool installed"
        else
            error "$tool not found"
            ((ISSUES++))
        fi
    done

    echo -e "\n${BLUE}=== Development Tools ===${NC}"
    local dev_tools=("nvim" "tmux" "fzf" "rg" "node")
    for tool in "${dev_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            success "$tool installed"
        else
            info "$tool not found (optional for development setup)"
        fi
    done
}

check_git_config() {
    echo -e "\n${BLUE}=== Git Configuration ===${NC}"

    local user_name=$(git config user.name 2>/dev/null)
    local user_email=$(git config user.email 2>/dev/null)

    if [[ -n "$user_name" ]]; then
        success "Git user name: $user_name"
    else
        warning "Git user name not configured"
    fi

    if [[ -n "$user_email" ]]; then
        success "Git user email: $user_email"
    else
        warning "Git user email not configured"
    fi

    # Check for sensitive data
    if git log --oneline -n 10 2>/dev/null | grep -q -E "(password|secret|key|token)" -i; then
        warning "Potential sensitive data in recent git commits"
        ((ISSUES++))
    fi
}

check_plugins() {
    echo -e "\n${BLUE}=== Plugin Status ===${NC}"

    # Tmux plugins
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        success "Tmux Plugin Manager installed"
    else
        info "TPM not found (run install script to set up)"
    fi

    # Neovim plugins
    if [[ -d "$HOME/.local/share/nvim/lazy" ]]; then
        success "Neovim Lazy.nvim installed"
        local plugin_count=$(find "$HOME/.local/share/nvim/lazy" -maxdepth 1 -type d | wc -l)
        info "Neovim plugins installed: $((plugin_count - 1))"
    else
        info "Neovim plugins not installed (run install script to set up)"
    fi
}

check_disk_usage() {
    echo -e "\n${BLUE}=== Repository Size ===${NC}"

    if [[ -d "$DOTFILES/.git" ]]; then
        local total_size=$(du -sh "$DOTFILES" 2>/dev/null | cut -f1)
        local git_size=$(du -sh "$DOTFILES/.git" 2>/dev/null | cut -f1)
        local config_size=$(du -sh "$DOTFILES" --exclude='.git' 2>/dev/null | cut -f1)

        info "Total repository size: $total_size"
        info "Git history size: $git_size"
        info "Configuration size: $config_size"

        # Warn if git history is disproportionately large
        local git_bytes=$(du -sb "$DOTFILES/.git" 2>/dev/null | cut -f1)
        local total_bytes=$(du -sb "$DOTFILES" 2>/dev/null | cut -f1)
        if [[ -n "$git_bytes" && -n "$total_bytes" ]] && (( git_bytes > total_bytes * 70 / 100 )); then
            warning "Git history is disproportionately large (>70% of total)"
            info "Consider running: git gc --aggressive"
        fi
    fi
}

suggest_improvements() {
    echo -e "\n${BLUE}=== Suggestions ===${NC}"

    # Check for modern tools
    local modern_tools=(
        "eza:modern ls replacement"
        "bat:modern cat with syntax highlighting"
        "zoxide:smarter cd command"
        "starship:modern prompt"
    )

    for tool_desc in "${modern_tools[@]}"; do
        local tool="${tool_desc%:*}"
        local desc="${tool_desc#*:}"
        if ! command -v "$tool" &>/dev/null; then
            info "Consider installing $tool ($desc)"
        fi
    done

    # Check shell performance
    if command -v zsh &>/dev/null; then
        local load_time=$(time zsh -i -c exit 2>&1 | grep real | cut -d' ' -f2 2>/dev/null || echo "unknown")
        if [[ "$load_time" != "unknown" ]]; then
            info "Shell load time: $load_time"
        fi
    fi
}

main() {
    echo -e "${BLUE}🔍 Dotfiles Doctor - Health Check${NC}\n"

    check_dotfiles_structure
    check_symlinks
    check_shell_config
    check_tools
    check_git_config
    check_plugins
    check_disk_usage
    suggest_improvements

    echo -e "\n${BLUE}=== Summary ===${NC}"
    if [[ $ISSUES -eq 0 ]]; then
        success "No critical issues found! Your dotfiles are healthy. 🎉"
    else
        warning "Found $ISSUES issue(s) that may need attention."
        echo -e "\n${BLUE}💡 To fix issues:${NC}"
        echo "  • Run ./scripts/setup/install.sh to reinstall/repair"
        echo "  • Check symlink targets manually"
        echo "  • Review git configuration"
    fi
}

main "$@"