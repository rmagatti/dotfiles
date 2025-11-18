require("mason").setup()

-- vim.lsp.enable({
--   "lua_ls",
--   "vtsls",
--   "yamlls",
--   "jsonls",
--   "vimls",
--   -- "rust_analyzer", -- rustaceanvim handles rust_analyzer setup so we don't need to manually enable it here
--   "basedpyright",
--   "biome",
--   "gopls",
--   "taplo",
--   "terraformls",
--   "tailwindcss"
-- })

vim.diagnostic.config({
  virtual_text = true, -- Show inline error/warning messages
  signs = true,        -- Show signs in the gutter
  underline = true,    -- Underline problematic code
  update_in_insert = false,
})
