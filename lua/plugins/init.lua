-- ============================================================
-- PLUGINS — lua/plugins/init.lua
-- Managed by lazy.nvim | Vanilla Neovim
-- ============================================================

return {
	-- ── Icons (dependency for tree/statusline/bufferline) ─────
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ── Theme: Catppuccin Mocha (synced with kitty) ───────────
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000, -- before alpha, which renders immediately
		config = function()
			require("configs.catppuccin")
		end,
	},

	-- ── Keybinding Visualizer (Which-Key) ──────────────────────
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 200,
			win = {
				wo = {
					winblend = 0,
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- ── Surround Motions (cs"', ysw", ds") ──────────────────────
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- ── Fast Code Commenting (gcc, gc) ─────────────────────────
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- ── Color Previewer (Hex / RGB highlights in code) ────────
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			user_default_options = {
				names = false,
				tailwind = true,
			},
		},
	},

	-- ── Completion (LSP + buffer + path + snippets) ───────────
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("configs.cmp")
		end,
	},

	-- ── Formatting (auto-format on save) ──────────────────────
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},

	-- ── LSP (language intelligence) ───────────────────────────
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp", "b0o/SchemaStore.nvim" },
		config = function()
			require("configs.lspconfig")
		end,
	},

	-- ── Markdown Rendering ────────────────────────────────────
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- ── Mason (auto-install LSP servers, formatters, linters) ─
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"html-lsp",
				"css-lsp",
				"typescript-language-server",
				"svelte-language-server",
				"tailwindcss-language-server",
				"eslint-lsp",
				"gopls",
				"docker-language-server",
				"intelephense",
				"rust-analyzer",
				"jdtls",
				"bash-language-server",
				"json-lsp",
				"yaml-language-server",
				"terraform-ls",
				"basedpyright",
				"ruff",
				-- Formatters
				"stylua",
				"prettier",
				"goimports-reviser",
				"gofumpt",
				"golines",
				"php-cs-fixer",
				"google-java-format",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
		end,
	},

	-- ── Treesitter (syntax highlighting & parsing) ────────────
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},

	-- ── Snacks (notifier, indent, zen, lazygit, bigfile) ──────
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = require("configs.snacks"),
	},

	-- ── Startup Dashboard (Alpha) ──────────────────────────────
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.alpha")
		end,
	},

	-- ── File Explorer ──────────────────────────────────────────
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.nvimtree")
		end,
	},

	-- ── Fuzzy Finder ───────────────────────────────────────────
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.telescope")
		end,
	},

	-- ── Git signs, hunks, blame ─────────────────────────────────
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.gitsigns")
		end,
	},

	-- ── Statusline ──────────────────────────────────────────────
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.lualine")
		end,
	},

	-- ── Buffer tabs ─────────────────────────────────────────────
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.bufferline")
		end,
	},

	-- ── Auto-close pairs: (), {}, [], "", '' ──────────────────
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},

	-- ── Auto-close and rename HTML/JSX tags ───────────────────
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- ── Emmet (fast HTML/JSX expansion: div>ul>li*3) ──────────
	{
		"mattn/emmet-vim",
		ft = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
	},

	-- ── Todo Comments (highlight & search TODO/FIXME/HACK) ────
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- ── Harpoon (quick file switcher) ─────────────────────────
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
	},

	-- ── Motion training: hardtime (hints better motions) ───────
	-- Spot `jjjj` / `llll` / arrow keys and tells you the vim way (5j, w, f, }).
	-- :Hardtime toggle | :Hardtime report (your worst habits)
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			restriction_mode = "hint", -- "block" once hints feel easy
			-- Only nag on real spam: 6+ presses of the same key within 1s.
			-- (default is 3, which fires on almost every normal j/k use)
			max_count = 5,
			disable_mouse = false,
			disabled_filetypes = { "NvimTree", "alpha", "lazy", "mason", "harpoon", "undotree", "TelescopePrompt" },
		},
	},

	-- ── Motion training: precognition (shows w/b/e/$/^/{/} hints)
	-- Off by default; <leader>tp to peek where motions would land.
	{
		"tris203/precognition.nvim",
		event = "VeryLazy",
		opts = { startVisible = false },
	},

	-- ── Undotree (visual undo history) ────────────────────────
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	-- ── Tmux Navigator ────────────────────────────────────────
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
	},

	-- ── Copilot ───────────────────────────────────────────────
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-y>",
					accept_word = "<C-t>",
					next = "<C-]>",
					prev = "<C-\\>",
					dismiss = "<C-e>",
				},
			},
			panel = { enabled = false },
		},
		config = function(_, opts)
			require("copilot").setup(opts)
			require("configs.learn").apply_copilot()
		end,
	},
}
