local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local tsserver_opts = vim.tbl_deep_extend("force", {}, {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      formatting = false,
      documentHighlightProvider = true,
      -- Offloading formatting to biomejs
      documentFormattingProvider = false,
      documentRangeFormattingProvider = false,
    }),

    on_attach = function(client, bufnr)
      -- Organize imports
      vim.keymap.set("n", "<leader>oi", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
      end, { desc = "Organize imports", buffer = bufnr })

      -- Add missing imports (not directly available in vtsls, but code actions might help)
      vim.keymap.set("n", "<leader>ai", function()
        vim.lsp.buf.code_action({ context = { only = { "source.addMissingImports" } }, apply = true })
      end, { desc = "Add missing imports", buffer = bufnr })

      -- Fix all issues
      vim.keymap.set("n", "<leader>fa", function()
        vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } }, apply = true })
      end, { desc = "Fix all issues", buffer = bufnr })

      -- Remove unused imports
      vim.keymap.set("n", "<leader>ru", function()
        vim.lsp.buf.code_action({ context = { only = { "source.removeUnused", "source.removeUnusedImports" } }, apply = true })
      end, { desc = "Remove unused imports", buffer = bufnr })

      -- Go to source definition
      vim.keymap.set("n", "<leader>gD", function()
        vim.lsp.buf.type_definition()
      end, { desc = "Go to type definition", buffer = bufnr })

      common_on_attach(client, bufnr)
    end,
  })

  require("lspconfig").vtsls.setup(tsserver_opts)
end

return M
