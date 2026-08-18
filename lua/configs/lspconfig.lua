-- ============================================================
-- LSP CONFIGURATION — lua/configs/lspconfig.lua
-- Servers: Lua, HTML, CSS, TypeScript, Tailwind, ESLint, Go
-- ============================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(_, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

-- ── Web & Lua servers (default config) ──────────────────────
local servers = {
  "html",
  "cssls",
  "lua_ls",
  "ts_ls",
  "tailwindcss",
  "eslint",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

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
