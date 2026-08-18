-- ============================================================
-- BUFFER TABS — lua/configs/bufferline.lua
-- ============================================================

-- Matches colors/tatsumaki.lua: bg = main background, bg_select = tab color.
-- Without an explicit `highlights` table, bufferline auto-darkens `Normal`'s
-- bg for the fill/gap area (-45%) and for tabs (-25%), which is the stray
-- near-black bar above the buffer area.
local bg = "#1E2B23"
local tab_bg = "#2C4033"
local border = "#5C6452"
local purple = "#5CC2D9"
local sage = "#ACBF9F"

require("bufferline").setup {
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_buffer_close_icons = true,
    show_close_icon = false,
    -- Left accent bar per tab: bright cursor color on the active buffer,
    -- sage on the rest, instead of the default underline.
    indicator = { icon = "▎", style = "icon" },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        -- A table (not a string like "Directory") makes bufferline generate
        -- its own highlight group with an explicit bg, instead of falling
        -- back to Directory's unset bg, which is a second source of the
        -- same auto-darkened patch fixed below for the rest of the tab bar.
        highlight = { fg = purple, bg = bg },
        separator = true,
      },
    },
  },
  highlights = {
    fill = { bg = bg },
    offset_separator = { fg = border, bg = bg },
    background = { bg = tab_bg },
    tab = { bg = tab_bg },
    tab_close = { bg = tab_bg },
    close_button = { bg = tab_bg },
    close_button_visible = { bg = tab_bg },
    close_button_selected = { bg = tab_bg },
    buffer = { bg = tab_bg },
    buffer_visible = { bg = tab_bg },
    buffer_selected = { bg = tab_bg },
    numbers = { bg = tab_bg },
    numbers_visible = { bg = tab_bg },
    numbers_selected = { bg = tab_bg },
    modified = { bg = tab_bg },
    modified_visible = { bg = tab_bg },
    modified_selected = { bg = tab_bg },
    duplicate = { bg = tab_bg },
    duplicate_visible = { bg = tab_bg },
    duplicate_selected = { bg = tab_bg },
    separator = { fg = bg, bg = tab_bg },
    separator_visible = { fg = bg, bg = tab_bg },
    separator_selected = { fg = bg, bg = tab_bg },
    indicator_selected = { fg = purple, bg = tab_bg },
    indicator_visible = { fg = sage, bg = tab_bg },
    diagnostic = { bg = tab_bg },
    diagnostic_visible = { bg = tab_bg },
    diagnostic_selected = { bg = tab_bg },
  },
}
