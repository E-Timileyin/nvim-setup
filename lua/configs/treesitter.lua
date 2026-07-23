-- ============================================================
-- TREESITTER CONFIGURATION — lua/configs/treesitter.lua
-- Syntax highlighting, indentation, and language parsing
-- ============================================================

local options = {
  ensure_installed = {
    -- Shell & config
    "bash", "toml", "yaml", "json",
    -- Lua / Vim
    "lua", "luadoc", "vim", "vimdoc",
    -- Web
    "html", "css", "javascript", "typescript", "tsx",
    -- Go
    "go", "gomod", "gosum",
    -- Docs
    "markdown", "printf",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}

-- Map .zsh files to use bash parser
vim.filetype.add {
  extension = {
    zsh = "bash",
  },
}

require("nvim-treesitter.configs").setup(options)
