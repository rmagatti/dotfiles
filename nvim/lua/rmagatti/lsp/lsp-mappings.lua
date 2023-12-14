---@diagnostic disable: undefined-field
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

M.on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { buffer = bufnr, silent = true }
  -- Code navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
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
  vim.keymap.set("n", "<localleader>a", vim.lsp.buf.code_action, opts)
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
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)         -- diagnostic next (not mneumonic but [ and ] work as next/previous)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)         -- diagnostic previous (not mneumonic)
  vim.keymap.set("n", "<leader>dl", function()
    require("telescope.builtin").diagnostics()
  end, opts)                                                        -- diagnostics telescope list
  vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, opts) -- diagnostic quickfix list

  -- Symbols
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>o", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>ws", function()
    return require("telescope.builtin").lsp_dynamic_workspace_symbols { ignore_symbols = { "node_modules/**" } }
  end, opts)
  vim.keymap.set("n", "<leader>wsf", function()
    return require("telescope.builtin").lsp_dynamic_workspace_symbols {
      symbols = { "function" },
    }
  end, opts)
  vim.keymap.set("n", "<leader>ds", function()
    return require("telescope.builtin").lsp_document_symbols()
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

  -- buf_set_keymap("n", "<leader>dac", function()
  --   vim.cmd "g/\v^(//<bar>.*//)/d_<CR>:w<CR>:noh<CR>"
  -- end, opts)

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    -- local colors = require("tokyonight.colors").setup {}

    -- Says fg_gutter is not a valid color but it either exists or nil is handled as what I want here.
    -- vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.fg_gutter })
    -- vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.fg_gutter })
    -- vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.bg_visual })

    -- vim.api.nvim_exec(
    --   [[
    --     augroup lsp_document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorHold <buffer> lua require('rmagatti.lsp.lsp-mappings').highlight_symbol()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --     augroup END
    -- ]],
    --   false
    -- )
  end
end

return M
