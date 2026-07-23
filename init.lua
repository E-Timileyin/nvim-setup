-- ============================================================
-- NEOVIM INIT — init.lua
-- Framework: NvChad v2.5 | Plugin Manager: lazy.nvim
-- Theme: Aura Dracula Spirit (Soft)
-- ============================================================

-- Enable bytecode caching for faster startup
if vim.loader then
  vim.loader.enable()
end

-- ── Core Settings ───────────────────────────────────────────
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Add Mason (LSP installer) and Go binaries to PATH
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.HOME .. "/go/bin:" .. vim.env.PATH
vim.opt.termguicolors = true

-- ── Bootstrap lazy.nvim ─────────────────────────────────────
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- ── Load Plugins ────────────────────────────────────────────
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- ── Load Theme ──────────────────────────────────────────────
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- ── Load User Config ────────────────────────────────────────
require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
