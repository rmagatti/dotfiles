local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local tsserver_opts = vim.tbl_deep_extend("force", {}, {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      formatting = false,
      documentHighlightProvider = true,
    }),
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>oi", ":TSToolsOrganizeImports", { silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>ai", ":TSToolsAddMissingImports", { silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>fa", ":TSToolsFixAll", { silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused", { silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", { silent = false, buffer = bufnr })
      vim.keymap.set("n", "<leader>gD", ":TSToolsGoToSourceDefinition<CR>", { silent = false, buffer = bufnr })

      common_on_attach(client, bufnr)
    end,

    -- Undocumented: typescript.nvim does not document this but passing in `init_options` into the server initialization works to set things like relative imports as the default.
    -- Reading this file is what gave me the clue: https://github.com/jose-elias-alvarez/typescript.nvim/blob/main/src/lsp.ts
    init_options = vim.tbl_deep_extend("force", {}, {
      preferences = {
        importModuleSpecifierPreference = "relative",
      },
    }),
    -- I had this added to test out https://github.com/typescript-language-server/typescript-language-server/issues/206
    -- No need for it if things are working properly
    -- cmd = { "/Users/ronnieandrewmagatti/Projects/typescript-language-server/lib/cli.js", "--stdio" },
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
