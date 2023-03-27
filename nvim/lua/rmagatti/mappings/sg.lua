vim.keymap.set("n", "<leader>ss", function()
  local word = vim.fn.expand "<cword>"
  require("sg.telescope").fuzzy_search_results { input = word }
end, {
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>sf", function()
  local word = vim.fn.expand "<cword>"
  local input = vim.fn.input "Filters > "
  require("sg.telescope").fuzzy_search_results { input = input .. " " .. word }
end, {
  noremap = true,
  silent = true,
})
