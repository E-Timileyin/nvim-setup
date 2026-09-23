-- ============================================================
-- LEARN MODE — lua/configs/learn.lua
-- Think first, assist second. Every session starts in learn mode:
--   - Copilot OFF (no AI ghost text)
--   - Completion menu only on <C-Space> (recall APIs yourself)
-- <leader>tl flips to work mode (both back on) and back again.
-- ============================================================

local M = {}

M.enabled = true

-- nvim-cmp `completion.autocomplete` value for the current mode
function M.autocomplete()
  if M.enabled then
    return false
  end
  return { require("cmp.types").cmp.TriggerEvent.TextChanged }
end

-- Copilot is lazy-loaded; only touch it once it exists
function M.apply_copilot()
  if not package.loaded["copilot"] then
    return
  end
  local cmd = require "copilot.command"
  if M.enabled then
    cmd.disable()
  else
    cmd.enable()
  end
end

function M.toggle()
  M.enabled = not M.enabled
  if package.loaded["cmp"] then
    require("cmp").setup { completion = { autocomplete = M.autocomplete() } }
  end
  M.apply_copilot()
  vim.notify(M.enabled and "Learn mode: assists OFF, think first" or "Work mode: Copilot + auto-completion ON")
end

return M
