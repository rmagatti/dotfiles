---@diagnostic disable: assign-type-mismatch
local M = {}

local setup_buffers = {}

M.on_attach = function(client, bufnr, augroup)
  -- Guard: only set up once per buffer
  if setup_buffers[bufnr] then
    return
  end

  -- Check if any client supports formatting or code actions
  local has_formatting = false
  local has_code_action = false
  local has_biome = false

  for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if c:supports_method("textDocument/formatting") then
      has_formatting = true
    end
    if c:supports_method("textDocument/codeAction") then
      has_code_action = true
    end
    if c.name == "biome" then
      has_biome = true
    end
  end

  -- Only set up if we have at least one capability
  if not (has_formatting or has_code_action) then
    return
  end

  setup_buffers[bufnr] = true

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = augroup,
    callback = function()
      -- Step 1: Biome organize imports (if biome is available)
      if has_biome and has_code_action then
        vim.lsp.buf.code_action({
          context = {
            only = { "source.organizeImports.biome" },
            diagnostics = {},
          },
          apply = true,
        })
      end

      -- Step 2: Biome fix all (if biome is available)
      if has_biome and has_code_action then
        vim.lsp.buf.code_action({
          context = {
            only = { "source.fixAll.biome" },
            diagnostics = {},
          },
          apply = true,
        })
      end

      -- Step 3: Remove unused imports/variables (synchronously)
      if has_code_action and not has_biome then
        vim.lsp.buf.code_action({
          context = {
            only = { "source.removeUnused", "source.removeUnusedImports" },
            diagnostics = {}
          },
          apply = true
        })
      end

      -- Step 4: Format the buffer (synchronously)
      if has_formatting then
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
      end
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
