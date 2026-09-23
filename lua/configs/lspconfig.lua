-- ============================================================
-- LSP CONFIGURATION — lua/configs/lspconfig.lua
-- Servers: Lua, HTML, CSS, TypeScript, Tailwind, ESLint, Go,
--          Rust, Java, Docker(+Compose), Bash, JSON, YAML, Terraform, Python
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
  root_dir = function(path)
    return vim.fs.root(path, { "go.work", "go.mod", ".git" })
  end,
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
