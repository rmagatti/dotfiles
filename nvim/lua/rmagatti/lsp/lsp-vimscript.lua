local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    cmd = { 'vim-language-server', '--stdio' },
    filetypes = { 'vim' },
    root_markers = { '.git' },
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("vimls", opts)
  vim.lsp.enable("vimls")
end

return M
