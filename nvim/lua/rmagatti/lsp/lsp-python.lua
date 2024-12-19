local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  require("lspconfig").pylsp.setup(vim.tbl_deep_extend("force", opts, {
    settings = {
      pylsp = {
        plugins = {
          ruff = { enabled = false },
          pylsp_mypy = { enabled = true },
          rope = { enabled = true },
          pylint = { enabled = false },

          black = { enabled = false },
          isort = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          mccabe = { enabled = false },
          preload = { enabled = false },
          pydocstyle = { enabled = false },
          yapf = { enabled = false },
        },
      },
    },
  }))

  -- require("lspconfig").ruff_lsp.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
