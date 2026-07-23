-- ============================================================
-- PLUGINS — lua/plugins/init.lua
-- Managed by lazy.nvim | NvChad v2.5
-- ============================================================

return {
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.treesitter"
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
