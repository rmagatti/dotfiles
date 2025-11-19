---@diagnostic disable: assign-type-mismatch
local M = {}

local setup_buffers = {}

M.on_attach = function(client, bufnr, augroup)
  -- Guard: only set up once per buffer
  if setup_buffers[bufnr] then
    return
  end
  setup_buffers[bufnr] = true

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = augroup,
    callback = function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.removeUnused", "source.removeUnusedImports" },
          diagnostics = {}
        },
        apply = true
      })
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
