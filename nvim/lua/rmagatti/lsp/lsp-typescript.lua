local M = {}

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach
  local typescript = require "typescript"

  local tsserver_opts = vim.tbl_deep_extend("force", {}, {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      formatting = false,
      documentHighlightProvider = true,
    }),
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>oi", typescript.actions.organizeImports, { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<leader>ai", typescript.actions.addMissingImports, { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<leader>fa", typescript.actions.fixAll, { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<leader>rf", "TypescriptRenameFile", { silent = true, buffer = bufnr })

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

  require("typescript").setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = tsserver_opts,
  }
end

return M
