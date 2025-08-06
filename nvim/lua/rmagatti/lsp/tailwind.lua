local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,

    filetypes = {
      "rust" -- Add rust here
    },

    document_config = {
      default_config = {
        settings = {
          tailwindCSS = {
            includeLanguages = {
              typescript = "javascript",
              javascript = "javascript",
              typescriptreact = "javascript",
              javascriptreact = "javascript",
              html = "html",
              svelte = "html",
              vue = "html",
              rust = "html",
              ["*.rs"] = "html"
            },
          }
        },
      }
    }
  }


  opts.filetypes = vim.tbl_extend(
    "keep",
    opts.filetypes or {},
    lspconfig.tailwindcss.document_config.default_config.filetypes -- Yes, this is where the default config is
  )

  lspconfig.tailwindcss.setup(opts)
end

return M
