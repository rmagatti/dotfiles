vim.o.completeopt = "menu,menuone,noselect,noinsert"

local cmp = require "cmp"
local lspkind = require "lspkind"
local mapping = cmp.mapping.preset.insert {
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),
  ["<CR>"] = cmp.mapping.confirm { select = true },
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),
  -- Disabled tab because of copilot conflict on tab
  -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
}

cmp.setup {
  formatting = {
    format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
  },
  experimental = {
    ghost_text = true,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = mapping,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "npm", keyword_length = 4 },
    -- TODO: enable me? disabling to try and debug input lag/freeze on insert mode
    -- { name = "nvim_lua" },
    -- { name = "rg" },
  }, {
    { name = "buffer" },
  }),
}

cmp.setup.filetype("lua", {
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
  },
})

-- TODO: enable me? disabling to try and debug input lag/freeze on insert mode
-- cmp.setup.cmdline("/", {
--   sources = {
--     { name = "buffer" },
--   },
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
