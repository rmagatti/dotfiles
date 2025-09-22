local M = {}

function M.setup()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("terraformls", opts)
  vim.lsp.enable("terraformls")
end

return M
