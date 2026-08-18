-- ============================================================
-- FILE EXPLORER — lua/configs/nvimtree.lua
-- ============================================================

require("nvim-tree").setup {
  view = { width = 30 },
  renderer = {
    highlight_git = false,
    icons = {
      show = { git = false },
    },
  },
  git = { enable = true, ignore = false },
  filters = { dotfiles = false },
  actions = {
    open_file = { quit_on_open = false },
  },
}
