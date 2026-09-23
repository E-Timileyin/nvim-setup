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
    svelte = { "prettier" },

    -- Go (import sorting -> formatting -> line length)
    go = { "goimports-reviser", "gofumpt", "golines" },

    -- Rust (needs `rustup component add rustfmt` — not a Mason package)
    rust = { "rustfmt" },

    -- Python (ruff: sort imports, then format)
    python = { "ruff_organize_imports", "ruff_format" },

    -- Java
    java = { "google-java-format" },

    -- Cloud / infra
    yaml = { "prettier" },
    terraform = { "terraform_fmt" },

    php = { "php-cs-fixer" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
