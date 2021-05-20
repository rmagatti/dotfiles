-- TS Utils
local ts_utils = require("nvim-lsp-ts-utils")
local mappings = require('rmagatti.lsp-mappings')

require('lspconfig').typescript.setup {
  on_attach = function (client, bufnr)

    ts_utils.setup {
      disable_commands = false,
      enable_import_on_completion = false,
      import_on_completion_timeout = 5000,
      -- eslint
      eslint_bin = "eslint_d",
      -- eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
      eslint_enable_disable_comments = true,

      -- experimental settings!
      -- eslint diagnostics
      eslint_enable_diagnostics = true,
      eslint_diagnostics_debounce = 250,
      -- formatting
      enable_formatting = true,
      formatter = "prettier_d_slim",
      formatter_args = {"--stdin", "--stdin-filepath", "$FILENAME", "--config", ".prettierrc", "--arrow-parens", "always", "--trailing-commas", "all"},
      format_on_save = true,
      no_save_after_format = false
    }

    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", ":TSLspOrganize<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>", {silent = true})

    mappings.on_attach(client, bufnr)

    require'lsp_signature'.on_attach {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ",  -- Panda for parameter
      hint_scheme = "String",

      handler_opts = {
        border = "single"   -- double, single, shadow, none
      },
      decorator = {"`", "`"}  -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help

    }
  end,
  -- TODO: get the PR for this change merged upstream
  cmd = {"/Users/ronnieandrewmagatti/.nvm/versions/node/v12.20.0/bin/node", "/Users/ronnieandrewmagatti/Projects/typescript-language-server/server/lib/cli.js", "--stdio", "--tsserver-user-preferences", "{\"importModuleSpecifierPreference\":\"relative\"}"}
}
