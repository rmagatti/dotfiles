local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    cmd = { 'taplo', 'lsp', 'stdio' },
    filetypes = { 'toml' },
    root_markers = { '*.toml', '.git' },
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("taplo", opts)
  vim.lsp.enable("taplo")
end

return M
