local M = {}

M.setup = function()
  require('telescope').setup {
    extensions = {
      ast_grep = {
        command = {
          "sg",                  -- For Linux, use `ast-grep` instead of `sg`
          "--json=stream",
        },                       -- must have --json=stream
        grep_open_files = false, -- search in opened files
        lang = nil,              -- string value, specify language for ast-grep `nil` for default
      }
    }
  }

  vim.keymap.set('n', '<leader>ag', function()
    require('telescope').extensions.ast_grep.ast_grep()
  end, { desc = 'Ast Grep' })
end

return M
