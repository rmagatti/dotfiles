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

local luadev = require("lua-dev").setup {
  lspconfig = {
    on_attach = mappings.on_attach
  }
}

lsp.lua.setup(luadev)
