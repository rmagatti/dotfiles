local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("basedpyright", vim.tbl_deep_extend("force", opts, {}))
  vim.lsp.enable("basedpyright")

  -- require("lspconfig").ruff_lsp.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
