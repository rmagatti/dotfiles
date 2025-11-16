local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc' },
    root_markers = { 'biome.json', 'biome.jsonc', '.git' },
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("biome", opts)
  vim.lsp.enable("biome")
end

return M
