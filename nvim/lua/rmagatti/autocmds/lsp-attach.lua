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
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Apply common mappings
    require('rmagatti.lsp.lsp-mappings').on_attach(client, bufnr)
  end,
})
