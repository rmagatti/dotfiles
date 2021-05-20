local lsp = require('lspconfig')
local mappings = require('rmagatti.lsp-mappings')
local lspinstall = require('lspinstall')
lspinstall.setup()

-- Initial setup
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

