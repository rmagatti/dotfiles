---@diagnostic disable: assign-type-mismatch
local M = {}

local setup_buffers = {}

M.on_attach = function(client, bufnr, augroup)
  if client.name ~= "biome" then
    return
  end

  -- Guard: only set up once per buffer
  if setup_buffers[bufnr] then
    return
  end
  setup_buffers[bufnr] = true

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = augroup,
    callback = function()
      -- Run organizeImports first, then fixAll after it completes
      vim.lsp.buf.code_action({
        context = {
          only = { "source.organizeImports.biome" },
          diagnostics = {},
        },
        apply = true,
      })
      
      -- Schedule fixAll to run after organizeImports completes
      vim.defer_fn(function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source.fixAll.biome" },
            diagnostics = {},
          },
          apply = true,
        })
      end, 100)
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
