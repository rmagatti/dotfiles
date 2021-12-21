-- local lsp = require "lspconfig"
local mappings = require "rmagatti.lsp.lsp-mappings"
local signature = require "rmagatti.lsp.lsp-signature"

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", ":TSLspOrganize<CR>", { silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", { silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>", { silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>", { silent = true })

  mappings.on_attach(client, bufnr)
  signature.on_attach()
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua
local luadev = require("lua-dev").setup {
  lspconfig = {
    on_attach = function(client, bufnr)
      mappings.on_attach(client, bufnr)
      signature.on_attach()
    end,
  },
}

local lsp_installer = require "nvim-lsp-installer"

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
  }

  if server.name == "sumneko_lua" then
    opts = vim.tbl_deep_extend("force", opts, luadev)
  end

  if server.name == "tsserver" then
    opts = vim.tbl_deep_extend("force", require("rmagatti.lsp.nvim-lsp-ts-utils").setup(on_attach), {
      capabilities = vim.tbl_deep_extend("force", capabilities, {
        formatting = false,
      }),

      -- I had this added to test out https://github.com/typescript-language-server/typescript-language-server/issues/206
      -- No need for it if things are working properly
      -- cmd = { "/Users/ronnieandrewmagatti/Projects/typescript-language-server/lib/cli.js", "--stdio" },
    })
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

require("rmagatti.lsp.null-ls").setup(on_attach)
