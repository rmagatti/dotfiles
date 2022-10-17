local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  require("neodev").setup { }

  local sumneko_lua_opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  require("lspconfig").sumneko_lua.setup(vim.tbl_deep_extend("force", sumneko_lua_opts, {}))
end

return M
