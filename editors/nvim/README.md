# My neovim setup

## Hey
Welcome, this is just my little personal neovim setup.


## Structure
```
.
├── init.lua
├── lazy-lock.json
├── lua/
│   ├── config/
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins/
│       ├── colorizer.lua
│       ├── colorscheme.lua
│       ├── completion.lua
│       ├── copilot.lua
│       ├── diffview.lua
│       ├── file_explorer.lua
│       ├── gitsigns.lua
│       ├── icons.lua
│       ├── illuminate.lua
│       ├── indent_blankline.lua
│       ├── lsp.lua
│       ├── lualine.lua
│       ├── mason.lua
│       ├── noice.lua
│       ├── oil_git_status.lua
│       ├── pdfview.lua
│       ├── telescope.lua
│       ├── tmux_statusline.lua
│       ├── treesitter.lua
│       ├── undotree.lua
│       └── lsp/
│       │   ├── diagnostics.lua
│       │   ├── keymaps.lua
│       │   └── servers/
│       │       ├── bash.lua
│       │       ├── clangd.lua
│       │       ├── init.lua
│       │       ├── lua.lua
│       │       ├── python.lua
│       │       └── swift.lua
└── README.md
```


## Plugins

|Plugin|Description|Repo|
|------|-----------|----|
| nvim-colorizer | Add colors to hex | [link](https://github.com/norcalli/nvim-colorizer.lua) |
| kanagawa.nvim | colorscheme | [link](https://github.com/rebelot/kanagawa.nvim) |
| nvim-cmp | completion | [link](https://github.com/hrsh7th/nvim-cmp) |
| copilot.lua | github copilot | [link](https://github.com/zbirenbaum/copilot.lua) |
| diffview.nvim | use git difftool | [link](https://github.com/sindrets/diffview.nvim) |
| oil.nvim | file explorer | [link](https://github.com/stevearc/oil.nvim) |
| gitsigns.nvim | Add git symbols to buffer | [link](https://github.com/lewis6991/gitsigns.nvim) |
| nvim-web-icons | add nerd-font icons to neovim | [link](https://github.com/nvim-tree/nvim-web-devicons) |
| vim-illuminate | highlight words | [link](https://github.com/RRethy/vim-illuminate) |
| indent-blankline.nvim | show indentation | [link](https://github.com/lukas-reineke/indent-blankline.nvim) |
| nvim-lspconfig | main lsp plugin | [link](https://github.com/neovim/nvim-lspconfig) |
| lualine.nvim | statusline ( for tmux statusline ) | [link](https://github.com/nvim-lualine/lualine.nvim) |
| mason.nvim | Load LSPs | [link](https://github.com/mason-org/mason.nvim) |
| noice.nvim | nicer ui | [link](https://github.com/folke/noice.nvim) |
| oil-git-status.nvim | add gitsigns to oil | [link](https://github.com/refractalize/oil-git-status.nvim) |
| PFDview | read PDFs in neovim | [link](https://github.com/basola21/PDFview) |
| telescope.nvim | use fzf and ripgrep to find files with nice ui | [link](https://github.com/nvim-telescope/telescope.nvim) |
| vim-tpipeline | merge tmux and neovim statusline | [link](https://github.com/vimpostor/vim-tpipeline) |
| nvim-treesitter | parser for syntax highlighting | [link](https://github.com/nvim-treesitter/nvim-treesitter) |
| undotree | show all undos | [link](https://github.com/jiaoshijie/undotree) |


## Keymaps
### Save & Quit
- `<leader>w`   -> Save
- `<leader>q`   -> Quit
- `<leader>wq` -> Save & Quit

### Quick escape
- `jj`          -> Escape mode


### Better navigation
- `<C-d>`       -> Go half page down and center
- `<C-u>`       -> Go half page up and center


### Visual mode improvements
- `<`           -> Better indent left
- `>`           -> Better indent right
- `J`           -> Move selected text down
- `K`           -> Move selected text up


## Infos LSP
*[L]anguage [S]erver [P]rotocol* is a commonly used protocol, that helps communication between code editors and *language servers*.
Each setup for each server is in the `lua/plugins/lsp/servers/` folder. Which then is loaded by the `nvim-lsp` plugin if a server is connected.
The servers are loaded by the `mason.nvim` plugin apart from clangd, which should always be installed on my systems.

### Keymaps
- `K`               -> Get info under cursor
- `gd`              -> Goto definition
- `<C-LeftMouse>`   -> Goto definition
- `gD`              -> Goto declaration
- `gr`              -> Show references with telescope
- `<M-LeftMouse>`   -> Show references with telescope
- `gi`              -> Goto implementation
- `<leader>ca`      -> Code action
- `<leader>rn`      -> Rename
- `<leader>f`       -> Format file
- `]d`              -> Goto next diagnostics
- `[d`              -> Goto previous diagnostics
- `<leader>e`       -> Show diagnostic



## DANGER
- compile_commands.json should be present for clangd lsp working correctly. ( use `bear` my friend )
- `vim-tpipeline` not working correctly when switching from a window containing neovim to another window
- `copilot.nvim` is mostly disabled, just have it because I have it free from school
