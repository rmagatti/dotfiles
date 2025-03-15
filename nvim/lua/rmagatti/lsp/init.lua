require("mason").setup()
require("mason-lspconfig").setup {}
require("rmagatti.lsp.lsp-lua").setup()
require("rmagatti.lsp.lsp-typescript").setup()
require("rmagatti.lsp.lsp-yaml").setup()
require("rmagatti.lsp.lsp-json").setup()
require("rmagatti.lsp.lsp-vimscript").setup()
require("rmagatti.lsp.lsp-rust").setup()
-- require("rmagatti.lsp.lsp-rust-owl").setup()
require("rmagatti.lsp.lsp-prisma").setup()
require("rmagatti.lsp.lsp-python").setup()
require("rmagatti.lsp.lsp-biome").setup()
require("rmagatti.lsp.lsp-go").setup()
require("rmagatti.lsp.lsp-toml").setup()
require("rmagatti.lsp.terraform").setup()

vim.diagnostic.config({
  virtual_text = true,   -- Show inline error/warning messages
  signs = true,          -- Show signs in the gutter
  underline = true,      -- Underline problematic code
  update_in_insert = false,
})
