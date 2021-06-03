-- TS Utils
local ts_utils = require("nvim-lsp-ts-utils")
local mappings = require('rmagatti.lsp-mappings')
local signature = require('rmagatti.lsp-signature')
local lsp_status = require('lsp-status')

require('lspconfig').typescript.setup {
  on_attach = function (client, bufnr)

    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      import_on_completion_timeout = 5000,
      -- eslint
      eslint_bin = "eslint_d",
      eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
      eslint_enable_disable_comments = true,

      -- experimental settings!
      -- eslint diagnostics
      eslint_enable_diagnostics = true,
      eslint_diagnostics_debounce = 2000,
      -- formatting
      enable_formatting = true,
      formatter = "prettier_d_slim",
      -- formatter_args = {"--stdin", "--stdin-filepath", "$FILENAME"},
      formatter_args = {"--stdin", "--stdin-filepath", "$FILENAME", "--config", ".prettierrc", "--arrow-parens", "always", "--trailing-commas", "all"},
      format_on_save = true,
      no_save_after_format = false,

      -- parentheses completion
      complete_parens = false,
      signature_help_in_parens = false,

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      watch_dir = "/src",

    }

    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", ":TSLspOrganize<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>", {silent = true})

    mappings.on_attach(client, bufnr)
    signature.on_attach()
    lsp_status.on_attach(client)
  end,
  capabilities = lsp_status.capabilities,
  -- TODO: get the PR for this change merged upstream
  cmd = {"/Users/ronnieandrewmagatti/.nvm/versions/node/v12.20.0/bin/node", "/Users/ronnieandrewmagatti/Projects/typescript-language-server/server/lib/cli.js", "--stdio", "--tsserver-user-preferences", "{\"importModuleSpecifierPreference\":\"relative\"}"}
}
