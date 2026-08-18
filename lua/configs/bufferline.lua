-- ============================================================
-- BUFFER TABS — lua/configs/bufferline.lua
-- ============================================================

require("bufferline").setup {
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    separator_style = "thin",
    show_buffer_close_icons = true,
    show_close_icon = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
}
