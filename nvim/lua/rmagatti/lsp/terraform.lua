local M = {}

function M.setup()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  require("lspconfig").terraformls.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
