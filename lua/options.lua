-- ============================================================
-- EDITOR OPTIONS — lua/options.lua
-- Performance-tuned, minimal UI, vim-native defaults
-- ============================================================

require "nvchad.options"

local o = vim.o

-- ── Speed Optimizations ─────────────────────────────────────
o.timeoutlen = 250    -- Faster key sequence timeout (default 1000)
o.updatetime = 200    -- Faster CursorHold / completion triggers (default 4000)

-- ── File Handling ───────────────────────────────────────────
o.swapfile = false    -- No swap files (rely on undofile for recovery)
o.undofile = true     -- Persistent undo across sessions (required for undotree)

-- ── Clipboard ───────────────────────────────────────────────
o.clipboard = "unnamedplus"  -- Sync yank/paste with system clipboard

-- ── Line Numbers ────────────────────────────────────────────
o.relativenumber = true  -- Relative line numbers (jump with Nj / Nk)

-- ── UI Performance ──────────────────────────────────────────
o.cursorlineopt = "number"  -- Only highlight the line number, not the whole line
