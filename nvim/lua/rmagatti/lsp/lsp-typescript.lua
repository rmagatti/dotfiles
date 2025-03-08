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
      documentRangeFormattingProvider = false
    }),
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>oi", ":TSToolsOrganizeImports<CR>",
        { desc = "Organize imports", silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>ai", ":TSToolsAddMissingImports<CR>",
        { desc = "Add missing imports", silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>fa", ":TSToolsFixAll<CR>", { desc = "Fix all issues", silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused<CR>",
        { desc = "Remove unused imports", silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>rf", ":TSToolsRenameFile<CR>",
        { desc = "Rename current file", silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>gD", ":TSToolsGoToSourceDefinition<CR>",
        { desc = "Go to source definition", silent = false, buffer = bufnr })

      common_on_attach(client, bufnr)
    end,
  })

  require("typescript-tools").setup {
    capabilities = tsserver_opts.capabilities,
    on_attach = tsserver_opts.on_attach,
    init_options = tsserver_opts.init_options,

    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
      tsserver_plugins = {
        -- for TypeScript v4.9+
        "@styled/typescript-styled-plugin",
        -- or for older TypeScript versions
        -- "typescript-styled-plugin",
      },
    },
  }
end

return M
