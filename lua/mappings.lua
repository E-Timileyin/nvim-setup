-- ============================================================
-- KEYBINDINGS — lua/mappings.lua
-- Leader: Space | Escape: jk
--
-- Design principles:
--   - Vim-native motions everywhere (h/j/k/l)
--   - Leader groups are mnemonic: f=find, g=git, h=harpoon
--   - [x / ]x brackets for prev/next navigation
--   - Ctrl+hjkl for window navigation (matches tmux Alt+hjkl)
-- ============================================================

local map = vim.keymap.set

-- ── General ─────────────────────────────────────────────────
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "File Save" })
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
map("n", "<leader>b", "<cmd> enew <CR>", { desc = "New buffer" })
map("n", "<leader>ya", "<cmd> %y+ <CR>", { desc = "Yank whole file" })

-- ── Buffers ─────────────────────────────────────────────────
map("n", "<Tab>", "<cmd> bnext <CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd> bprevious <CR>", { desc = "Previous buffer" })
-- Bracket alternative (doesn't depend on the Tab key reaching the terminal)
map("n", "]b", "<cmd> bnext <CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd> bprevious <CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd> bd <CR>", { desc = "Close buffer" })

-- ── File Explorer ───────────────────────────────────────────
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle file explorer" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus file explorer" })

-- ── Better Indenting (stay in visual mode after indent) ─────
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ── Move Text Up/Down (visual mode) ────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

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
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Recent files" })
map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "Marks" })
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
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status (telescope)" })
map("n", "]h", function() require("gitsigns").nav_hunk "next" end, { desc = "Next git hunk" })
map("n", "[h", function() require("gitsigns").nav_hunk "prev" end, { desc = "Previous git hunk" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- ── Toggles (leader + t) ───────────────────────────────────
map("n", "<leader>tl", function() require("configs.learn").toggle() end, { desc = "Toggle learn/work mode" })
map("n", "<leader>ts", "<cmd> SyntaxToggle <CR>", { desc = "Toggle muted syntax colors" })
map("n", "<leader>tp", function() require("precognition").toggle() end, { desc = "Toggle motion hints" })
map("n", "<leader>th", "<cmd> Hardtime toggle <CR>", { desc = "Toggle hardtime (motion coach)" })

-- ── Snacks (zen mode, notification history) ────────────────
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Zen mode" })
map("n", "<leader>sn", function() Snacks.notifier.hide() end, { desc = "Dismiss notifications" })
