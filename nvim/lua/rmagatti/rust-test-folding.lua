local function fold_rust_tests_cfg()
  local bufnr = vim.api.nvim_get_current_buf()

  local query = vim.treesitter.query.parse("rust", [[
      (
        (attribute_item
          (attribute) @attr (#contains? @attr "test")
          ) @attrItem
        (mod_item
          name: (identifier) @modName)
        (#contains? @modName "test")
      ) @captureName
    ]])

  -- vim.notify("Folding Rust test modules based on #[cfg(test)]...", vim.log.levels.DEBUG)

  local parser = vim.treesitter.get_parser(bufnr, "rust")
  if not parser then
    return
  end

  local tree = parser:parse()[1]
  if not tree then
    return
  end
  local root = tree:root()

  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if node and query.captures[id] == "modName" then
      local s, _, _, _ = node:range() -- 0-indexed values
      local fold_line = s + 1         -- Convert to Vim's 1-indexed line number

      -- Save the current cursor position.
      local cur_pos = vim.api.nvim_win_get_cursor(0)
      -- Move the cursor to the start of the test module.
      vim.api.nvim_win_set_cursor(0, { fold_line, 0 })
      -- Recalculate folds (this forces the foldexpr to update).
      vim.cmd("normal! zx")
      -- Try to close the fold at the current cursor line.
      vim.cmd("normal! zc")
      -- Restore your original cursor position.
      vim.api.nvim_win_set_cursor(0, cur_pos)

      -- vim.notify(string.format("Attempted folding test module at line %d", fold_line), vim.log.levels.DEBUG)
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- Delay a bit to ensure Tree‑sitter has parsed the file.

    vim.defer_fn(function()
      -- Save original fold settings and apply them after the fold.
      local original_foldmethod = vim.opt_local.foldmethod
      local original_foldexpr = vim.opt_local.foldexpr
      local original_foldtext = vim.opt_local.foldtext

      -- Set buffer-local fold settings
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"
      vim.cmd("normal! zx")

      -- Apply the folding
      fold_rust_tests_cfg()

      -- Restore original fold settings
      vim.opt_local.foldmethod = original_foldmethod
      vim.opt_local.foldexpr = original_foldexpr
      vim.opt_local.foldtext = original_foldtext
    end, 500)
  end,
})
