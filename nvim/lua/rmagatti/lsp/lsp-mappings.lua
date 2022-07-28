local M = {}

do
  local on = false
  function M.toggle_symbol_highlight()
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
    vim.lsp.buf.document_highlight()
  end
end

M.on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.keymap.set(...)
    -- vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { buffer = bufnr, silent = true }
  -- Code navigation
  buf_set_keymap("n", "gD", vim.lsp.buf.declaration, opts)
  buf_set_keymap("n", "gd", vim.lsp.buf.definition, opts)
  buf_set_keymap("n", "K", vim.lsp.buf.hover, opts)
  buf_set_keymap("n", "gi", vim.lsp.buf.implementation, opts)
  buf_set_keymap("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, opts)

  -- Type helpers
  buf_set_keymap("n", "<leader>gs", vim.lsp.buf.signature_help, opts)
  -- buf_set_keymap("n", "<leader>gt", vim.lsp.buf.type_definition, opts)

  -- Not too sure what this does
  buf_set_keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  buf_set_keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  buf_set_keymap("n", "<leader>wl", function()
    return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Refactoring and actions
  buf_set_keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  buf_set_keymap("n", "<localleader>a", vim.lsp.buf.code_action, opts)
  buf_set_keymap("n", "<M-CR>", vim.lsp.buf.code_action, opts)
  buf_set_keymap("n", "<CR>", vim.lsp.buf.code_action, opts)

  -- Diagnostics
  buf_set_keymap("n", "<leader>e", vim.diagnostic.open_float, opts) -- not mneumonic
  buf_set_keymap("n", "[d", vim.diagnostic.goto_next, opts) -- diagnostic next (not mneumonic but [ and ] work as next/previous)
  buf_set_keymap("n", "]d", vim.diagnostic.goto_prev, opts) -- diagnostic previous (not mneumonic)
  buf_set_keymap("n", "<leader>dl", function()
    require("telescope.builtin").diagnostics()
  end, opts) -- diagnostics telescope list
  buf_set_keymap("n", "<leader>dq", vim.diagnostic.setqflist, opts) -- diagnostic quickfix list

  -- Symbols
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>o", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
  buf_set_keymap("n", "<leader>ws", function()
    return require("telescope.builtin").lsp_dynamic_workspace_symbols { file_ignore_patterns = { "node_modules/**" } }
  end, opts)
  buf_set_keymap("n", "<leader>ds", function()
    return require("telescope.builtin").lsp_document_symbols()
  end, opts)

  if client.server_capabilities.documentHighlightProvider then
    buf_set_keymap("n", "h", function()
      return require("rmagatti.lsp.lsp-mappings").toggle_symbol_highlight()
    end, opts)
  end

  buf_set_keymap("n", "<leader>fo", vim.lsp.buf.format, opts)
  buf_set_keymap("v", "<leader>fo", vim.lsp.buf.range_formatting, opts)

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua require('rmagatti.lsp.lsp-mappings').highlight_symbol()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
    ]],
      false
    )
  end
end

return M
