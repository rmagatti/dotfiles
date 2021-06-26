local lsp = require('lspconfig')
local mappings = require('rmagatti.lsp-mappings')
local signature = require('rmagatti.lsp-signature')
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspinstall = require('lspinstall')
lspinstall.setup()

-- Initial setup
local servers = lspinstall.installed_servers()
for _, server in pairs(servers) do
  lsp[server].setup{
    on_attach = function (client, bufnr)
      mappings.on_attach(client, bufnr)
      lsp_status.on_attach(client)
    end,
    capabilities = lsp_status.capabilities
  }
end

-- lsp.lua.setup {
--   on_attach = function (client, bufnr)
--     mappings.on_attach(client, bufnr)
--     signature.on_attach()
--   end
-- }

-- FIXME: removed because seems to be causing high cpu usage
local luadev = require("lua-dev").setup {
  lspconfig = {
    on_attach = function (client, bufnr)
      mappings.on_attach(client, bufnr)
      signature.on_attach()
    end
  }
}

lsp.lua.setup(luadev)

