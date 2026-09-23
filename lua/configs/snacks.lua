-- ============================================================
-- SNACKS — lua/configs/snacks.lua
-- Only modules with no overlap against alpha/nvim-tree/telescope.
-- Everything else stays unset (snacks skips unconfigured modules
-- entirely, so this costs nothing at startup).
-- ============================================================

return {
  bigfile = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  -- no animation: the animated scope guide redraws on every scroll step
  indent = { enabled = true, animate = { enabled = false } },
  zen = { enabled = true },
  lazygit = { enabled = true },
}
