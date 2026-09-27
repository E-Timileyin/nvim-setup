-- ============================================================
-- LSP CONFIGURATION — lua/configs/lspconfig.lua
-- Servers: Lua, HTML, CSS, TypeScript, Tailwind, ESLint, Go,
--          Rust, Java, PHP, Docker(+Compose), Bash, JSON, YAML, Terraform, Python
-- ============================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(_, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

-- Recognize docker-compose files so docker_language_server treats them as
-- compose (not plain Dockerfile/YAML) — mirrors the .zsh->bash mapping in
-- treesitter.lua.
vim.filetype.add {
  pattern = {
    [".*docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    [".*compose.*%.ya?ml"] = "yaml.docker-compose",
  },
}

-- ── Default-config servers (web, systems, backend, cloud) ────
local servers = {
  "html",
  "cssls",
  "lua_ls",
  "ts_ls",
  "svelte",
  "tailwindcss",
  "eslint",
  "jdtls",
  "docker_language_server",
  "bashls",
  "terraformls",
  "basedpyright",
  "ruff",
  "intelephense",
}

-- ── Blade templates ─────────────────────────────────────────
-- .blade.php must resolve to `blade`, not `php`: Laravel's HTML inside
-- {{ }} / @directives otherwise parses as raw PHP and destroys
-- indent + highlight. Neovim's runtime already ships this rule, but
-- it lives in vim.filetype.match's whole-filename layer — restating it
-- keeps it working if that runtime changes, and documents why.
vim.filetype.add {
  pattern = {
    ["%.blade%.php$"] = "blade",
  },
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- ── JSON / YAML with SchemaStore (package.json, tsconfig, k8s,
-- GitHub Actions, docker-compose, CloudFormation, ... validated) ─
vim.lsp.config("jsonls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
  },
})
vim.lsp.enable "jsonls"

vim.lsp.config("yamlls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" }, -- use SchemaStore.nvim instead
      schemas = require("schemastore").yaml.schemas(),
      keyOrdering = false,
    },
  },
})
vim.lsp.enable "yamlls"

-- ── Rust (rust-analyzer — clippy on save, all cargo features) ─
vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
})
vim.lsp.enable "rust_analyzer"

-- ── PHP (intelephense) ─────────────────────────────────────
-- Built-in formatting is disabled: conform.nvim runs php-cs-fixer on
-- save instead. Two formatters racing the same buffer is how you get
-- phantom diffs. intelephense also ships a paid "premium" tier; every
-- feature enabled here is free-tier, so no license key is needed.
vim.lsp.config("intelephense", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php", "blade" },
  -- Use root_markers, not a hand-rolled root_dir. Neovim's root_dir
  -- contract is `root_dir(bufnr, cb)` and is called asynchronously; a
  -- plain `function(path) return ... end` ignores the callback, so the
  -- server is silently never started — no error, nothing in :LSPLog.
  -- root_markers lets Neovim build the correct async root_dir itself.
  root_markers = { "composer.json", ".git" },
  settings = {
    intelephense = {
      telemetry = { enabled = false },
      -- Laravel's facades, Eloquent magic methods, and Collection
      -- chain methods are dynamic; without these every `Model::find()`
      -- and `$collection->map()` is an "undefined symbol" error.
      stubs = {
        "apache",
        "bcmath",
        "bz2",
        "calendar",
        "com_dotnet",
        "Core",
        "ctype",
        "curl",
        "date",
        "dba",
        "dom",
        "enchant",
        "exif",
        "FFI",
        "fileinfo",
        "filter",
        "fpm",
        "ftp",
        "gd",
        "gettext",
        "gmp",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "ldap",
        "libxml",
        "mbstring",
        "mysqli",
        "openssl",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "pdo_pgsql",
        "pdo_sqlite",
        "Phar",
        "posix",
        "pspell",
        "readline",
        "redis",
        "Reflection",
        "session",
        "shmop",
        "SimpleXML",
        "snmp",
        "soap",
        "sockets",
        "sodium",
        "SPL",
        "sqlite3",
        "standard",
        "sysvmsg",
        "sysvsem",
        "sysvshm",
        "tokenizer",
        "xml",
        "xmlreader",
        "xmlrpc",
        "xmlwriter",
        "xsl",
        "zip",
        "zlib",
        "phpstorm-stubs",
      },
      environment = {
        -- Point this at the project's vendor dir when you have several
        -- Laravel checkouts open; auto-detection picks the nearest
        -- vendor/ or composer.json either way.
        includePaths = {},
      },
      files = {
        maxSize = 5000000,
        exclude = {
          "**/.git/**",
          "**/.svn/**",
          "**/.hg/**",
          "**/node_modules/**",
          "**/vendor/**/{Tests,tests}/**",
          "**/storage/framework/**",
          "**/bootstrap/cache/**",
        },
      },
      format = { enable = false },
      diagnostics = {
        -- `@param`/`@return` mismatches on Laravel's magic methods are
        -- mostly noise; keep real errors.
        undefinedMethods = true,
        undefinedFunctions = true,
        undefinedConstants = true,
        undefinedVariables = false,
        undefinedTypes = true,
      },
    },
  },
})
vim.lsp.enable "intelephense"

-- ── Go (gopls — custom: disable built-in formatting) ────────
-- Formatting is handled by conform.nvim (goimports-reviser + gofumpt + golines)
vim.lsp.config("gopls", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  -- root_markers rather than root_dir: the root_dir signature is
  -- `(bufnr, cb)` and async, so a sync function silently prevents the
  -- server from ever starting (this was why gopls never attached).
  -- go.work wins over go.mod so multi-module workspaces resolve to one root.
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
})
vim.lsp.enable "gopls"

-- ── Diagnostics ──────────────────────────────────────────────
vim.diagnostic.config {
  virtual_text = { prefix = "●" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
