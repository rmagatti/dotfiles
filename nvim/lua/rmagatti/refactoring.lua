-- local refactor = require("refactoring")
-- refactor.setup()

-- telescope refactoring helper
local function refactor(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry()
  require("telescope.actions").close(prompt_bufnr)
  require("refactoring").refactor(content.value)
end

-- NOTE: M is a global object
-- for the sake of simplicity in this example
-- you can extract this function and the helper above
-- and then require the file and call the extracted function
-- in the mappings below
M = {}
M.refactors = function()
  local opts = require("telescope.themes").get_cursor() -- set personal telescope options
  require("telescope.pickers").new(opts, {
    prompt_title = "refactors",
    finder = require("telescope.finders").new_table({
      results = require("refactoring").get_refactors(),
    }),
    sorter = require("telescope.config").values.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<CR>", refactor)
      map("n", "<CR>", refactor)
      return true
    end
  }):find()
end

vim.api.nvim_set_keymap("v", "<Leader>re", [[<cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})

return M
