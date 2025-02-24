local function fold_rust_tests_cfg()
  local bufnr = vim.api.nvim_get_current_buf()

  local query = vim.treesitter.query.parse("rust", [[
      (
            (attribute_item ; [34, 0] - [34, 12]
                  (attribute ; [34, 2] - [34, 11]
                          (identifier) @cfgName ; [34, 2] - [34, 5]
                              arguments: (token_tree ; [34, 5] - [34, 11]
                                                     (identifier) @testName))) ; [34, 6] - [34, 10]
            (mod_item
              name: (identifier) @modName)
            (#eq? @testName "test")
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
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.cmd("normal! zx")
      -- vim.notify("Auto-folding `tests` modules with #[cfg(test)]", vim.log.levels.DEBUG)
      fold_rust_tests_cfg()
    end, 500)
  end,
})
