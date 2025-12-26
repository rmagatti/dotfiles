require("mason").setup()

-- Configure LSP floating window borders
local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

-- Override LSP floating window handlers to use borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local augroup = vim.api.nvim_create_augroup('PreSaveActions', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    -- Enable inlay hints if supported
    if client:supports_method('textDocument/inlayHint', bufnr) then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end


    require('rmagatti.lsp.lsp-mappings').on_attach(client, bufnr)

    -- Single module handles all save actions synchronously
    require("rmagatti.lsp.on-save").on_attach(client, bufnr, augroup)
  end,
})

vim.diagnostic.config({
  virtual_text = true, -- Show inline error/warning messages
  signs = true,        -- Show signs in the gutter
  underline = true,    -- Underline problematic code
  update_in_insert = false,
  float = {
    border = border,
    source = "always",
    header = "",
    prefix = "",
  },
})
