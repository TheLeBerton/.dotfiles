Welcome to my personal dotfiles! This repository contains my development environment configurations, designed for **multi-platform use** across macOS, Linux (Ubuntu, Fedora), and specialized environments like 42 school.

## ✨ Overview

These dotfiles feature a **modular, category-based structure** with intelligent platform detection and automated installation. Everything is organized by function rather than tool, making it easy to install only what you need.

### 🛠 Configured Tools

**Shell & Terminal:**
- **Zsh** – Modular shell configuration with platform detection
- **Tmux** – Terminal multiplexer with theme and plugins
- **Kitty** – GPU-accelerated terminal emulator

**Development:**
- **Neovim** – Modern Lua-based editor with LSP, completion, and plugins
- **Git** – Global configuration with aliases and commit templates

**Desktop (Linux/Wayland):**
- **Hyprland** – Wayland compositor with modular config
- **Waybar** – Status bar for Wayland
- **Rofi** – Application launcher with multiple themes
- **Dunst/Mako** – Notification daemons
- **Swaylock** – Screen locker

**Utilities:**
- **Custom scripts** – Brightness, volume, wifi, session management
- **RMPC** – Remote MPD client

## 📁 Repository Structure

```
.dotfiles/
├── shell/zsh/          # Shell configurations
│   ├── modules/        # Modular zsh components
│   └── .zshrc          # Main shell entry point
├── terminal/           # Terminal emulators & multiplexer
│   ├── tmux/          # Tmux configuration
│   └── kitty/         # Kitty terminal config
├── editors/nvim/       # Neovim configuration
│   ├── lua/           # Lua-based config
│   └── lsp/           # Language server configs
├── dev/git/           # Development tools
├── desktop/           # Desktop environment (Linux/Wayland)
│   ├── hyprland/      # Wayland compositor
│   ├── rofi/          # Application launcher
│   ├── waybar/        # Status bar
│   └── audio/rmpc/    # Audio player client
├── scripts/           # Utility scripts
│   ├── setup/         # Installation automation
│   └── utils/         # System utilities
└── templates/         # Git templates
```

## 🚀 Installation

**Automated Installation:**
```bash
git clone https://github.com/TheLeberton/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./scripts/setup/install.sh
```

**Installation Options:**
```bash
./scripts/setup/install.sh           # Install everything
./scripts/setup/install.sh --dev     # Development tools only
./scripts/setup/install.sh --desktop # Desktop environment only
./scripts/setup/install.sh --zsh     # Shell configuration only
```

**Manual Setup:**
```bash
# Core shell config
ln -sf ~/.dotfiles/shell/zsh/.zshrc ~/.zshrc

# Development environment
ln -sf ~/.dotfiles/editors/nvim ~/.config/nvim
ln -sf ~/.dotfiles/dev/git/config ~/.gitconfig
```

## 🌍 Platform Support

**Fully Supported:**
- **macOS** (M1/Intel) – Complete shell, development, and terminal setup
- **Linux Ubuntu** – Full desktop environment + development tools
- **42 School Ubuntu** – Special homebrew detection and paths
- **Asahi Linux (Fedora)** – ARM Linux support

**Auto-Detection Features:**
- Platform-specific PATH management
- Conditional plugin loading
- Environment-aware configurations

## 📌 Goals

* **Cross-platform consistency** – Same workflow across all machines
* **Modular design** – Install only what you need
* **Smart automation** – Intelligent platform detection
* **Performance focus** – Optimized configurations for speed
* **Easy maintenance** – Clear structure and documentation

## 🧠 Philosophy

* **Simple over complex** – Readable configs over clever tricks
* **Modular over monolithic** – Small, focused files
* **Portable over platform-specific** – Works everywhere with adaptations
* **Documented over mysterious** – Clear comments and structure

## 📋 Dependencies

Dependencies are automatically installed by the setup script. Key requirements:
- **Git** (for repository operations)
- **Zsh** (shell)
- **Curl/Wget** (downloads)
- **Platform-specific**: Homebrew (macOS), apt/dnf (Linux)

---

🚀 **Ready to use:** Clone, run install script, enjoy!
🔧 **Easy to modify:** Clear structure, documented configs
🌟 **Feedback welcome:** Issues and suggestions appreciated!
