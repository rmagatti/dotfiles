local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "Dotfiles",
    cwd = "~/Projects/dotfiles/nvim",
  }
end

M.setup = function()
  vim.keymap.set(
    "n",
    "<leader>sdf",
    require('rmagatti.telescope.dotfiles').search_dotfiles,
    { noremap = true }
  )
end

return M
