-- ============================================================
-- STATUSLINE — lua/configs/lualine.lua
-- Aura Dracula Spirit (Soft) themed
-- ============================================================

local c = {
  bg = "#191521",
  bg_dark = "#14111b",
  fg = "#edecee",
  fg_dark = "#adacae",
  purple = "#a277ff",
  cyan = "#82e2ff",
  green = "#61ffca",
  orange = "#ffca85",
  red = "#ff6767",
}

local aura = {
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
    theme = aura,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
