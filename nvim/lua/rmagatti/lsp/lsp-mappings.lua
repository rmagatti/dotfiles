---@diagnostic disable: assign-type-mismatch
local M = {}

do
  local on = false
  local has_autocmd = false
  local autocmd_id

  function M.toggle_symbol_highlight()
    if not has_autocmd then
      autocmd_id = vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        pattern = "*",
        callback = require("rmagatti.lsp.lsp-mappings").highlight_symbol,
      })
      has_autocmd = true
    else
      vim.api.nvim_del_autocmd(autocmd_id)
      has_autocmd = false
    end

    if on then
      vim.lsp.buf.clear_references()
      on = false
    else
      vim.lsp.buf.document_highlight()
      on = true
    end
  end

  function M.highlight_symbol()
    if not on then
      return
    end
    vim.lsp.buf.clear_references()
    vim.lsp.buf.document_highlight()
  end
end

vim.keymap.set("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify("Inlay Hints " .. (vim.lsp.inlay_hint.is_enabled() and "Enabled" or "Disabled"))
end, { desc = "Toggle Inlay Hints" })

M.on_attach = function(client, bufnr, augroup)
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- Mappings.
  local opts = { buffer = bufnr, silent = true }
  -- Code navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", function()
    require("snacks").picker.lsp_references()
  end, opts)

  -- Type helpers
  vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, opts)
  -- buf_set_keymap("n", "<leader>gt", vim.lsp.buf.type_definition, opts)

  -- Not too sure what this does
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Refactoring and actions
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "g.", vim.lsp.buf.code_action, opts)
  vim.keymap.set({ "n", "x", "v" }, "<M-CR>", vim.lsp.buf.code_action, opts)

  if
      type(client.server_capabilities.codeActionProvider) == "table"
      and not vim.tbl_isempty(client.server_capabilities.codeActionProvider)
      or client.server_capabilities.codeActionProvider ~= nil
  then
    if vim.bo.filetype == "vimwiki" then
      return
    end

    vim.keymap.set({ "n", "x", "v" }, "<CR>", vim.lsp.buf.code_action, opts)
  end

  -- Diagnostics
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- not mneumonic
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts) -- diagnostic next (not mneumonic but [ and ] work as next/previous)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts) -- diagnostic previous (not mneumonic)
  vim.keymap.set("n", "<leader>dl", function()
    require("snacks").picker.diagnostics()
  end, opts)                                                        -- diagnostics telescope list
  vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, opts) -- diagnostic quickfix list

  -- Symbols
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>o", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>ws", function()
    return require("snacks").picker.lsp_workspace_symbols()
  end, opts)
  vim.keymap.set("n", "<leader>wsf", function()
    return require("snacks").picker.lsp_workspace_symbols()
  end, opts)
  vim.keymap.set("n", "<leader>ds", function()
    return require("snacks").picker.lsp_symbols()
  end, opts)

  if client.server_capabilities.documentHighlightProvider then
    vim.keymap.set("n", "h", function()
      return require("rmagatti.lsp.lsp-mappings").toggle_symbol_highlight()
    end, opts)
  end

  vim.keymap.set("n", "<leader>fo", function()
    vim.lsp.buf.format { async = true }
  end, opts)
  vim.keymap.set("v", "<leader>fo", function()
    vim.lsp.buf.format { async = true }
  end, opts)

  vim.keymap.set("n", "<leader>oi", function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source.organizeImports" },
        diagnostics = {}
      },
      apply = true
    })
  end, { desc = "Organize imports", buffer = bufnr })

  -- Add missing imports
  vim.keymap.set("n", "<leader>ai", function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source.addMissingImports" },
        diagnostics = {}
      },
      apply = true
    })
  end, { desc = "Add missing imports", buffer = bufnr })

  -- Fix all issues
  vim.keymap.set("n", "<leader>fa", function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source.fixAll" },
        diagnostics = {}
      }
      ,
      apply = true
    })
  end, { desc = "Fix all issues", buffer = bufnr })

  -- Remove unused imports
  vim.keymap.set("n", "<leader>ru", function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source.removeUnused", "source.removeUnusedImports" },
        diagnostics = {}
      },
      apply = true
    })
  end, { desc = "Remove unused imports", buffer = bufnr })

  -- Go to source definition
  vim.keymap.set("n", "<leader>gD", function()
    vim.lsp.buf.type_definition()
  end, { desc = "Go to type definition", buffer = bufnr })
end

return M
