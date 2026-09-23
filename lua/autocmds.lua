-- ============================================================
-- AUTOCOMMANDS — lua/autocmds.lua
-- ============================================================

local autocmd = vim.api.nvim_create_autocmd

-- ── Single-buffer mode ──────────────────────────────────────
-- Auto-close previous buffer when opening a new file.
-- Mimics VS Code's single-tab behavior (no buffer pile-up).
autocmd("BufEnter", {
  callback = function()
    vim.schedule(function()
      local current = vim.api.nvim_get_current_buf()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current
          and vim.api.nvim_buf_is_valid(buf)
          and vim.bo[buf].buflisted
          and vim.bo[buf].buftype == ""
          and not vim.bo[buf].modified
        then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end)
  end,
})

-- ── Breadcrumb header (path + line, under the tab bar) ─────
-- Only on real file buffers — stays off nvim-tree, alpha, terminals, etc.
autocmd({ "BufWinEnter", "BufEnter" }, {
  callback = function()
    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
      vim.wo.winbar = "  %#WinBar#%f  %l"
    else
      vim.wo.winbar = nil
    end
  end,
})
