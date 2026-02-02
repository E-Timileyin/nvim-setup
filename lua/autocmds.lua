local autocmd = vim.api.nvim_create_autocmd

-- Example autocmd: Don't continue comments on new lines
-- autocmd("BufEnter", {
--   pattern = "*",
--   command = "set formatoptions-=cro",
-- })
