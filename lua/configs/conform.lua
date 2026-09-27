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

    php = { "pint", "php_cs_fixer" },
    -- No blade entry on purpose. Prettier has no Blade parser: it either
    -- no-ops ("No parser could be inferred") or, forced with --parser html,
    -- collapses @extends/@section directives onto single lines and reflows
    -- directive nesting, corrupting the template. There is no reliable
    -- Blade formatter in the Mason registry worth wiring up.
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },

  -- Pint (Laravel's php-cs-fixer wrapper) needs no config file, so it is
  -- tried first; php-cs-fixer covers plain PHP projects. Conform already
  -- resolves both from vendor/bin upward with a PATH fallback, and already
  -- pins php-cs-fixer's cwd to the composer.json root — so a Laravel
  -- project formats with its own pinned version rather than a global one.
  formatters = {
    -- google-java-format hardcodes 2-space indents and reads no editorconfig;
    -- --aosp is the only way to get 4. It is a whole style variant, not just a
    -- width: line continuations indent 8 instead of 4. Delete this table to
    -- go back to Google style.
    ["google-java-format"] = {
      prepend_args = { "--aosp" },
    },

    php_cs_fixer = {
      -- Conform's default only looks in vendor/bin and PATH. Mason installs
      -- to a data dir that is not on PATH, so add it as the last resort.
      -- This must be a closure, not a direct call: this file is loaded by
      -- lazy.nvim before conform.nvim is on the runtimepath, so requiring
      -- conform.util at the top level fails. `command` is resolved per-run.
      command = function(self, ctx)
        return require("conform.util").find_executable({
          "tools/php-cs-fixer/vendor/bin/php-cs-fixer",
          "vendor/bin/php-cs-fixer",
        }, vim.fn.stdpath "data" .. "/mason/bin/php-cs-fixer")(self, ctx)
      end,
      -- php-cs-fixer aborts with a banner when it cannot find a
      -- composer.json. With cwd pinned to the composer root, cwd is nil
      -- outside a PHP project, and this skips the run instead of erroring
      -- on every save.
      require_cwd = true,
    },
  },
}

return options
