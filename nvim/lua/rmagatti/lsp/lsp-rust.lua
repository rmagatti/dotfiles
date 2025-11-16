local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    default_settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        -- cargo = { features = { "ssr", "hydrate" } },
        checkOnSave = true,
        check = {
          enable = true,
          command = 'clippy',
          features = 'all',
        },
        procMacro = {
          enable = true,
          ignored = {
            leptos_macro = {
              "server",
            },
          },
        },
      },
    }
  }

  vim.g.rustaceanvim = {
    server = opts,
  }
end

return M
