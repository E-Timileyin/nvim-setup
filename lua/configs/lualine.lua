-- ============================================================
-- STATUSLINE — lua/configs/lualine.lua
-- Catppuccin Mocha theme (from the catppuccin plugin)
-- ============================================================

local learn = require "configs.learn"

require("lualine").setup {
  options = {
    theme = "catppuccin-mocha",
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      -- Current mode at a glance (<leader>tl to switch)
      { function() return learn.enabled and "󰑴 learn" or "󰚩 work" end },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
