-- ============================================================
-- NEOVIM INIT — init.lua
-- Vanilla Neovim | Plugin Manager: lazy.nvim
-- Theme: Aura Dracula Spirit (Soft) — colors/aura.lua
-- ============================================================

-- Enable bytecode caching for faster startup
if vim.loader then
  vim.loader.enable()
end

-- ── Core Settings ───────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- ── Load User Config ────────────────────────────────────────
require "options"
require "autocmds"

-- ── Load Plugins ────────────────────────────────────────────
local lazy_config = require "configs.lazy"
require("lazy").setup({ { import = "plugins" } }, lazy_config)

-- ── Load Theme ──────────────────────────────────────────────
vim.cmd.colorscheme "aura"

vim.schedule(function()
  require "mappings"
end)
