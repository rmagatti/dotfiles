local M = {}

local setup_buffers = {}

M.on_attach = function(client, bufnr, augroup)
  -- Guard: only set up once per buffer
  if setup_buffers[bufnr] then
    return
  end

  -- Check if any client supports formatting
  local has_formatting = false
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if c.supports_method("textDocument/formatting") then
      has_formatting = true
      break
    end
  end

  if not has_formatting then
    return
  end

  setup_buffers[bufnr] = true

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = augroup,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr, async = false })
    end,
  })

  -- Cleanup when buffer is deleted
  vim.api.nvim_create_autocmd('BufDelete', {
    buffer = bufnr,
    once = true,
    callback = function()
      setup_buffers[bufnr] = nil
    end,
  })
end

return M
