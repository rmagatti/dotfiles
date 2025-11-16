local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  vim.lsp.config("basedpyright", opts)
  vim.lsp.enable("basedpyright")

  -- require("lspconfig").ruff_lsp.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
