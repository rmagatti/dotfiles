local lsp = require('lspconfig')
local mappings = require('rmagatti.lsp-mappings')
local lspinstall = require('lspinstall')
lspinstall.setup()

local servers = lspinstall.installed_servers()
for _, server in pairs(servers) do
  lsp[server].setup{
    on_attach = mappings.on_attach
  }
end

lsp.lua.setup {
  on_attach = mappings.on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- TS Utils
local ts_utils = require("nvim-lsp-ts-utils")
lsp.typescript.setup {
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
      formatter_args = {"--stdin", "--stdin-filepath", "$FILENAME", "--config", ".prettierrc", "--arrow-parens", "always"},
      format_on_save = true,
      no_save_after_format = false
    }

    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", ":TSLspOrganize<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>", {silent = true})

    mappings.on_attach(client, bufnr)
  end,
  cmd = {"/Users/ronnieandrewmagatti/.nvm/versions/node/v12.20.0/bin/node", "/Users/ronnieandrewmagatti/Projects/typescript-language-server/server/lib/cli.js", "--stdio", "--tsserver-user-preferences", "{\"importModuleSpecifierPreference\":\"relative\"}"}
}

-- LSP diagnostics | Folke
-- require("trouble").setup()

-- -- Symbols
-- require('symbols-outline').setup {
--   highlight_hovered_item = true,
--   show_guides = true,
-- }

-- require'lsp_signature'.on_attach({
--   bind = true, -- This is mandatory, otherwise border config won't get registered.
--   -- If you want to hook lspsaga or other signature handler, pls set to false
--   doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

--   hint_enable = true, -- virtual hint enable
--   hint_prefix = "🐼 ",  -- Panda for parameter
--   hint_scheme = "String",

--   handler_opts = {
--     border = "shadow"   -- double, single, shadow, none
--   },
--   decorator = {"`", "`"}  -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help
-- })
