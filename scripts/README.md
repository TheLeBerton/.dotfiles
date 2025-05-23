```text
#################################################################
#                                                               #
#  #####                       ##                ##             #
# ##   ##                                        ##             #
# #         ####    ######    ###     ######    #####    #####  #
#  #####   ##  ##    ##  ##    ##      ##  ##    ##     ##      #
#      ##  ##        ##        ##      ##  ##    ##      #####  #
# ##   ##  ##  ##    ##        ##      #####     ## ##       ## #
#  #####    ####    ####      ####     ##         ###   ######  #
#                                     ####                      #
#################################################################
```

# 📁 Structure

```
/001 󰉋  conf/
├── 008 󰈔  all
├── 009 󰈔  dev
├── 010 󰈔  hyprland
├── 011 󰈔  kitty
├── 012 󰦪  lab_repos.txt
├── 013 󰈔  neovim
├── 014 󰈔  reset_lab
├── 015 󰦪  scripts_to_run.txt
└── 016 󰈔  update
    └── 017   zsh

/002 󰉋  git/
├── 008 󰈔  check_repos
├── 009 󰈔  is_pushed
├── 010 󰈔  pull_all
└── 011 󰈔  push_vog

/004 󰉋  tasks/
├── 008 󰈔  add_task
├── 009 󰈔  mark_task
├── 010 󰈔  remove_task
├── 011 󰈔  show_all_tasks
├── 012 󰈔  show_undone_tasks
├── 013 󰈔  task
└── 015 󰈔  vim_the_task

/005 󰈔  tmux-sessionizer

/006 󰉋  utils/
├── 008 󰈔  addlib
├── 009 󰈔  log_out
├── 010 󰈔  send_notification
└── 011 󰈔  slow_echo
```

---

## 🧩 Conf

This folder contains configuration scripts to set up my environment exactly how I like it.
Everything is orchestrated using the `$DEV` variable, which points to the main `dev` script.

---

## 🛠️ Git

A set of helper scripts for managing Git workflows more easily and consistently.

---

## ✅ Tasks

Scripts to manage a personal to-do list directly from the terminal.
Includes adding, marking, and removing tasks — plus a Vim interface.

---

## ⚙️ Utils

Small utility scripts that make my workflow smoother, such as notifications, logging, and output tweaks.

---

## 🧠 Notes

* Most scripts are intended to be modular and used with symlinks or aliases.
* Compatible with macOS and Linux.

