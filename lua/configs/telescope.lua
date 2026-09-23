-- ============================================================
-- FUZZY FINDER — lua/configs/telescope.lua
-- ============================================================

require("telescope").setup {
  defaults = {
    prompt_prefix  = "  ",
    selection_caret = " ",
    sorting_strategy = "ascending",
    layout_config  = { prompt_position = "top" },
  },
}

pcall(require("telescope").load_extension, "fzf")
