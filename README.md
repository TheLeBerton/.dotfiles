Welcome to my personal dotfiles! This repository contains the configuration files I use for my development and daily computing environment, primarily focused on **macOS** and soon to be adapted more for **Linux** (especially Wayland and Ubuntu environments).

## ✨ Overview

These dotfiles are designed to be **simple**, **efficient**, and tailored to my personal workflow. I don't use any dotfile manager yet — just raw control via symlinks or future scripts.

### Configured Tools

- **Hyprland** – Wayland compositor
- **Neovim** – My main code editor
- **tmux** – Terminal multiplexer
- **Waybar** – Status bar for Wayland
- **zsh** – Shell configuration
- **Custom scripts** – Utilities I often use

## 📁 Repository Structure

```
.
├── hypr/          # Hyprland configuration
├── nvim/          # Neovim config (Lua-based)
├── scripts/       # Custom shell scripts
├── tmux/          # Tmux config
├── waybar/        # Waybar config
└── zshrc          # Zsh configuration file
````

> 🛠 This structure may evolve as I polish my system and create installation scripts.

## 🚀 Setup (Manual for now)

I currently don't use a dotfile manager. To use these configs, you can manually symlink them or copy the files to your config directories:

```bash
git clone https://github.com/LeoTrain/dotfiles.git
cd dotfiles
# Example:
ln -s ~/.dotfiles/nvim ~/.config/nvim
````

Scripts and setup automation are coming soon!

## 📌 Goals

* Keep my environment consistent across machines
* Prioritize speed, clarity, and usability
* Create simple installation scripts for Linux in the future

## 🧠 Notes

* These dotfiles are a work in progress.
* macOS support is partial; Linux will be the main focus moving forward.
* Dependencies will be documented later.

---

Feel free to fork or explore. Feedback and suggestions are welcome!
