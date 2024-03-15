local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  vim.keymap.set("n", "<leader>x", function()
    -- "<cmd>RustLsp explainError<CR>"
    vim.cmd.RustLsp("explainError")
  end, { silent = true })

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    default_settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = true,
        check = {
          enable = true,
          command = 'clippy',
          features = 'all',
        },
        procMacro = {
          enable = true,
        },
      },
    }
  }

  vim.g.rustaceanvim = {
    server = opts,
  }
end

return M
