local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose' },
    root_markers = { '.git' },
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("yamlls", opts)
  vim.lsp.enable("yamlls")
end

return M
