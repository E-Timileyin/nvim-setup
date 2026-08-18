-- ============================================================
-- STATUSLINE — lua/configs/lualine.lua
-- Tatsumaki themed — matches kitty terminal (colors/tatsumaki.lua)
-- ============================================================

local c = {
  bg = "#1E2B23",
  bg_dark = "#1E2B23",
  fg = "#C8D9C0",
  fg_dark = "#5C6452",
  purple = "#5CC2D9",
  cyan = "#ACBF9F",
  green = "#6EE384",
  orange = "#EEE359",
  red = "#E0543F",
}

local tatsumaki = {
  normal = {
    a = { fg = c.bg, bg = c.purple, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_dark },
    c = { fg = c.fg_dark, bg = c.bg },
  },
  insert = { a = { fg = c.bg, bg = c.green, gui = "bold" } },
  visual = { a = { fg = c.bg, bg = c.orange, gui = "bold" } },
  replace = { a = { fg = c.bg, bg = c.red, gui = "bold" } },
  command = { a = { fg = c.bg, bg = c.cyan, gui = "bold" } },
  inactive = {
    a = { fg = c.fg_dark, bg = c.bg_dark },
    b = { fg = c.fg_dark, bg = c.bg_dark },
    c = { fg = c.fg_dark, bg = c.bg },
  },
}

require("lualine").setup {
  options = {
    theme = tatsumaki,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", color = { fg = c.purple } },
      "diff",
      "diagnostics",
    },
    lualine_c = { { "filename", path = 1, color = { fg = c.purple } } },
    lualine_x = { { "filetype", color = { fg = c.purple } } },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
