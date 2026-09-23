-- ============================================================
-- FILE EXPLORER — lua/configs/nvimtree.lua
-- ============================================================

-- "u" defaults to Rename: Full Path, which is one keystroke away from the
-- muscle-memory expectation of "undo" — remove it, keep r/e/<C-r> for renaming.
local function on_attach(bufnr)
  require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
  vim.keymap.del("n", "u", { buffer = bufnr })
end

require("nvim-tree").setup {
  view = { width = 24 },
  renderer = {
    highlight_git = false,
    indent_width = 1,
    root_folder_label = false,
    icons = {
      padding = " ",
      show = { git = false },
    },
  },
  git = { enable = true, ignore = false },
  filters = { dotfiles = false },
  actions = {
    open_file = { quit_on_open = false },
  },
  on_attach = on_attach,
}
