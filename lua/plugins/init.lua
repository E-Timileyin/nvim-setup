-- ============================================================
-- PLUGINS — lua/plugins/init.lua
-- Managed by lazy.nvim | Vanilla Neovim (no framework)
-- ============================================================

return {
  -- ── Icons (dependency for tree/statusline/bufferline) ─────
  { "nvim-tree/nvim-web-devicons", lazy = true },

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
      require "configs.cmp"
    end,
  },

  -- ── Formatting (auto-format on save) ──────────────────────
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- ── LSP (language intelligence) ───────────────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require "configs.lspconfig"
    end,
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
        "tailwindcss-language-server",
        "eslint-lsp",
        "gopls",
        -- Formatters
        "stylua",
        "prettier",
        "goimports-reviser",
        "gofumpt",
        "golines",
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
      require "configs.treesitter"
    end,
  },

  -- ── File explorer ──────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.nvimtree"
    end,
  },

  -- ── Fuzzy finder ────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.telescope"
    end,
  },

  -- ── Git signs, hunks, blame ─────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.gitsigns"
    end,
  },

  -- ── Statusline ──────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.lualine"
    end,
  },

  -- ── Buffer tabs ─────────────────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.bufferline"
    end,
  },

  -- ── Indent guides ───────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
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

  -- ── Harpoon (quick file switcher — mark up to 4 files) ────
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- ── Undotree (visual undo history) ────────────────────────
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  -- ── Tmux Navigator (seamless nvim splits <-> tmux panes) ──
  -- Mappings defined in lua/mappings.lua (Ctrl+hjkl, Alt+hjkl);
  -- falls back to plain window nav when not inside tmux.
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },

  -- ── Copilot (inline ghost text suggestions) ───────────────
  -- Accept: Ctrl+y | Next: Ctrl+] | Prev: Ctrl+\ | Dismiss: Ctrl+e
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-y>",       -- Ctrl+y  accept suggestion
          accept_word = "<C-t>",  -- Ctrl+t  accept word
          next = "<C-]>",         -- Ctrl+]  next suggestion
          prev = "<C-\\>",       -- Ctrl+\  previous suggestion
          dismiss = "<C-e>",      -- Ctrl+e  dismiss
        },
      },
      panel = { enabled = false },
    },
  },
}
