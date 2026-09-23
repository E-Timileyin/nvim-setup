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
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

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

-- ── Glassmorphism (fully transparent — wallpaper shows through) ────
opt.pumblend  = 0   -- 0 = fully opaque text on transparent bg (sharp, readable)
opt.winblend  = 0   -- 0 = no blending artifacts with NONE backgrounds

-- ── UI Performance ──────────────────────────────────────────
opt.cursorlineopt = "number"  -- Only highlight the line number, not the whole line

-- ── Wrap navigation across line boundaries ──────────────────
opt.whichwrap:append "<>[]hl"

-- ── Mouse / touchpad scroll speed (default ver:3) ───────────
opt.mousescroll = "ver:6,hor:6"

if vim.fn.has "nvim-0.10" == 1 then
  opt.smoothscroll = true
end
