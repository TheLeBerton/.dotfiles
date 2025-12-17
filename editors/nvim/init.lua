-- ========================================================================== --
-- ==                      STEP 1: BASE + LAZY.NVIM                        == --
-- ========================================================================== --

-- Leader key (doit être défini AVANT lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ========================================================================== --
-- ==                           EDITOR OPTIONS                             == --
-- ========================================================================== --

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false -- tabs au lieu d'espaces
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.colorcolumn = "80"
opt.showmode = false

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Borders
opt.winborder = "rounded"

-- ========================================================================== --
-- ==                        BASIC KEYMAPS                                 == --
-- ========================================================================== --

local keymap = vim.keymap.set

-- Save/Quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>wq", ":wq<CR>", { desc = "Save and Quit" })

-- Quick escape
keymap("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- Better navigation
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down + center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up + center" })

-- Visual mode improvements
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- ========================================================================== --
-- ==                          LAZY.NVIM SETUP                             == --
-- ========================================================================== --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- Mason: LSP/formatter/linter installer
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason-lspconfig: bridge between mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Setup mason-lspconfig first
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"bashls",
				},
				automatic_installation = true,
			})

			-- LSP keymaps (only when LSP is attached)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("gr", vim.lsp.buf.references, "Show References")
					map("gi", vim.lsp.buf.implementation, "Goto Implementation")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, "Format")
					map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
					map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
				end,
			})

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Diagnostic configuration
			vim.diagnostic.config({
				float = { border = "rounded" },
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Lua LSP
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}

			-- C/C++ LSP
			vim.lsp.config.clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--function-arg-placeholders=true",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
				capabilities = capabilities,
			}

			-- Python LSP
			vim.lsp.config.pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
						},
					},
				},
			}

			-- Bash LSP
			vim.lsp.config.bashls = {
				cmd = { "bash-language-server", "start" },
				filetypes = { "sh", "bash" },
				root_markers = { ".git" },
				capabilities = capabilities,
			}

			-- Swift LSP
			vim.lsp.config.sourcekit = {
				cmd = { "sourcekit-lsp" },
				filetypes = { "swift", "objective-c", "objective-cpp" },
				root_markers = { "buildServer.json", ".xcodeproj", ".xcworkspace", "Package.swift", ".git" },
				capabilities = capabilities,
			}

			-- Enable all configured LSPs
			vim.lsp.enable({ "lua_ls", "clangd", "pyright", "bashls", "sourcekit" })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = "➜ ",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.6,
						},
					},
					file_ignore_patterns = {
						"node_modules/",
						".git/",
						"*.o",
						"*.a",
					},
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<ESC>"] = "close",
						}
					},
				}
			})
		end,
		keys = {
			{ "<C-f>",      "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<C-g>",      "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
		},
	},
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source
			"hrsh7th/cmp-buffer", -- Buffer source
			"hrsh7th/cmp-path", -- Path source
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet source
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},

	-- Oil: File Explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = { "icon" },
				view_options = {
					show_hidden = false,
				},
				float = {
					padding = 2,
					max_width = 90,
					border = "rounded",
				},
				keymaps = {
					["q"] = "actions.close",
					["<C-c>"] = "actions.close",
				},
			})
		end,
		keys = {
			{ "-",         "<cmd>Oil --float<cr>",         desc = "Open parent directory" },
			{ "<leader>-", "<cmd>Oil<cr>", desc = "Open Oil float" },
		},
	},

	-- nvim-web-devicons: Icons pour Oil
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
			})
		end,
	},

	-- Treesitter: Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"python",
					"bash",
					"markdown",
					"json",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}, {
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- ========================================================================== --
-- ==                          AUTOCMDS                                    == --
-- ========================================================================== --

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
