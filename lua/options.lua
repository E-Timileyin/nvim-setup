-- ============================================================
-- EDITOR OPTIONS — lua/options.lua
-- Performance-tuned, minimal UI, vim-native defaults
-- ============================================================

local opt = vim.opt

-- ── UI ───────────────────────────────────────────────────────
opt.laststatus = 3
opt.showmode = false
opt.cursorline = true
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.winborder = "rounded"
opt.mouse = "a"
opt.termguicolors = true

-- ── Indenting ────────────────────────────────────────────────
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- ── Search ───────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true

-- ── Splits ───────────────────────────────────────────────────
opt.splitbelow = true
opt.splitright = true

-- ── Speed Optimizations ─────────────────────────────────────
opt.timeoutlen = 250   -- Faster key sequence timeout (default 1000)
opt.updatetime = 200   -- Faster CursorHold / completion triggers (default 4000)

-- ── File Handling ───────────────────────────────────────────
opt.swapfile = false   -- No swap files (rely on undofile for recovery)
opt.undofile = true    -- Persistent undo across sessions (required for undotree)

-- ── Clipboard ───────────────────────────────────────────────
opt.clipboard = "unnamedplus"  -- Sync yank/paste with system clipboard

-- ── Line Numbers ────────────────────────────────────────────
opt.relativenumber = true  -- Relative line numbers (jump with Nj / Nk)

-- ── UI Performance ──────────────────────────────────────────
opt.cursorlineopt = "number"  -- Only highlight the line number, not the whole line

-- ── Wrap navigation across line boundaries ──────────────────
opt.whichwrap:append "<>[]hl"

if vim.fn.has "nvim-0.10" == 1 then
  opt.smoothscroll = true
end
