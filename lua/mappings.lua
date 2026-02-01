require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- File Save
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "File Save" })

-- Format Code
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

-- Better Indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move Text Up/Down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Clear Search Highlights
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Diagnostic Jump (Errors/Warnings)
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map( "n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic setloclist" } )
