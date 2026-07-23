-- ============================================================
-- FORMATTER CONFIGURATION — lua/configs/conform.lua
-- Auto-formats on save with 500ms timeout
-- ============================================================

local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    -- Web (Prettier handles all JS/TS/CSS/HTML)
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },

    -- Go (import sorting -> formatting -> line length)
    go = { "goimports-reviser", "gofumpt", "golines" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
