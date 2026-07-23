-- ============================================================
-- KEYBINDINGS — lua/mappings.lua
-- Leader: Space | Escape: jk
--
-- Design principles:
--   - Vim-native motions everywhere (h/j/k/l)
--   - Leader groups are mnemonic: g=git, f=find, h=harpoon
--   - [x / ]x brackets for prev/next navigation
--   - Ctrl+hjkl for window navigation (matches tmux Alt+hjkl)
-- ============================================================

require "nvchad.mappings"

local map = vim.keymap.set

-- ── General ─────────────────────────────────────────────────
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "File Save" })

-- ── Better Indenting (stay in visual mode after indent) ─────
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ── Move Text Up/Down (visual mode) ────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Clear Search Highlights ─────────────────────────────────
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

-- ── Window Navigation (seamless nvim splits <-> tmux panes) ─
-- vim-tmux-navigator: at the edge of nvim, jumps to the next
-- tmux pane; outside tmux it falls back to plain <C-w> nav.
-- Ctrl+hjkl and Alt+hjkl both work (tmux binds both too).
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window right" })
map("n", "<A-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<A-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<A-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window up" })
map("n", "<A-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window right" })

-- ── LSP (go-to with g prefix, actions with leader) ─────────
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover info" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

-- ── Diagnostics (bracket navigation: [d / ]d) ──────────────
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })

-- ── Format ──────────────────────────────────────────────────
map("n", "<leader>fm", function()
  require("conform").format { lsp_format = "fallback" }
end, { desc = "Format file" })

-- ── Telescope / Find (leader + f) ──────────────────────────
map("n", "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "LSP document symbols" })
map("n", "<leader>fS", "<cmd> Telescope lsp_workspace_symbols <CR>", { desc = "LSP workspace symbols" })
map("n", "<leader>fd", "<cmd> Telescope diagnostics <CR>", { desc = "Telescope diagnostics" })

-- ── Todo Comments (leader + ft, brackets [t / ]t) ──────────
map("n", "<leader>ft", "<cmd> TodoTelescope <CR>", { desc = "Find TODOs" })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next TODO" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous TODO" })

-- ── Harpoon (leader + h = harpoon, leader + N = file N) ────
map("n", "<leader>ha", function() require("harpoon"):list():add() end, { desc = "Harpoon add file" })
map("n", "<leader>hh", function()
  local harpoon = require "harpoon"
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })
map("n", "<leader>1", function() require("harpoon"):list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<leader>2", function() require("harpoon"):list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<leader>3", function() require("harpoon"):list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<leader>4", function() require("harpoon"):list():select(4) end, { desc = "Harpoon file 4" })

-- ── Undotree ────────────────────────────────────────────────
map("n", "<leader>u", "<cmd> UndotreeToggle <CR>", { desc = "Toggle Undotree" })

-- ── Git (leader + g = git, brackets [h / ]h for hunks) ─────
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Git preview hunk" })
map("n", "<leader>gb", function() require("gitsigns").blame_line { full = true } end, { desc = "Git blame line" })
map("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Git stage hunk" })
map("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Git reset hunk" })
map("n", "]h", function() require("gitsigns").nav_hunk "next" end, { desc = "Next git hunk" })
map("n", "[h", function() require("gitsigns").nav_hunk "prev" end, { desc = "Previous git hunk" })
