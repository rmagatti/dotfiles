require("neodev").setup()

local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

require("mason").setup {}
require("mason-lspconfig").setup {}
require("rmagatti.lsp.lsp-lua").setup()
require("rmagatti.lsp.lsp-typescript").setup()
require("rmagatti.lsp.lsp-yaml").setup()
require("rmagatti.lsp.lsp-json").setup()
require("rmagatti.lsp.lsp-vimscript").setup()
require("rmagatti.lsp.lsp-rust").setup()
require("rmagatti.lsp.lsp-prisma").setup()

require("rmagatti.lsp.null-ls").setup(common_on_attach)
