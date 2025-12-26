local M = {}

M.search_dotfiles = function()
  local Snacks = require("snacks")
  
  Snacks.picker.files({
    cwd = vim.fn.expand("~/Projects/dotfiles/nvim"),
    prompt = "Dotfiles> ",
  })
end

M.setup = function()
  vim.keymap.set("n", "<leader>sdf", M.search_dotfiles, { desc = "Search dotfiles" })
end

return M
