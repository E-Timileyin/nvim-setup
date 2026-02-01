local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults() -- loads nvchad default lsp options

local servers = {
  "html",
  "cssls",
  "lua_ls",
  "ts_ls",
  "tailwindcss",
  "eslint",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end

-- Configure gopls
vim.lsp.config("gopls", {
  on_attach = function(client, _)
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
