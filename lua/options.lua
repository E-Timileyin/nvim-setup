require "nvchad.options"

local o = vim.o

-- SPEED OPTIMIZATIONS

-- Reduce timeoutlen for faster Alt key response (and general key sequence responsiveness)
o.timeoutlen = 250

-- Faster completion/hover updates
o.updatetime = 200

-- Disable swap files (reduces disk I/O, rely on git/undofile for recovery)
o.swapfile = false

-- UI Performance
-- Only highlight the line number, not the whole line (faster in large files)
o.cursorlineopt = "number"
