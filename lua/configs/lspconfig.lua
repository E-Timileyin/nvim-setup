-- ============================================================
-- LSP CONFIGURATION — lua/configs/lspconfig.lua
-- Servers: Lua, HTML, CSS, TypeScript, Tailwind, ESLint, Go
-- ============================================================

local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

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
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(lsp)
end

-- ── Go (gopls — custom: disable built-in formatting) ────────
-- Formatting is handled by conform.nvim (goimports-reviser + gofumpt + golines)
vim.lsp.config("gopls", {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
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
