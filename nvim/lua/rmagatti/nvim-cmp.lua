vim.o.completeopt = "menu,menuone,noselect,noinsert"

-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
-- end

local cmp = require "cmp"
local lspkind = require "lspkind"
local mapping = cmp.mapping.preset.insert {
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete {},
  ["<C-e>"] = cmp.mapping.close(),
  ["<CR>"] = cmp.mapping.confirm { select = true },
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),
  -- Disabled tab because of copilot conflict on tab
  -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
  --   if cmp.visible() and has_words_before() then
  --     cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  --   else
  --     fallback()
  --   end
  -- end),
}

cmp.setup {
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      max_width = 50,
      symbol_map = { Copilot = "" },
    },
  },
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = mapping,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "vsnip" },
    { name = "luasnip" },
    { name = "path" },
    { name = "npm", keyword_length = 4 },
    { name = "copilot", group_index = 2 },
    { name = "neorg" },
  }, {
    { name = "buffer" },
  }),
}

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup.filetype("lua", {
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    -- { name = "nvim_lua" },
  },
})

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
