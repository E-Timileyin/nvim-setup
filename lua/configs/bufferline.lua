-- ============================================================
-- BUFFER TABS — lua/configs/bufferline.lua
-- Catppuccin Mocha highlights (from the catppuccin plugin)
-- ============================================================

require("bufferline").setup {
  highlights = require("catppuccin.special.bufferline").get_theme(),
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_buffer_close_icons = true,
    show_close_icon = false,
    indicator = { icon = "▎", style = "icon" },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        separator = true,
      },
    },
  },
}
