local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "Dotfiles",
    cwd = "~/Projects/dotfiles/nvim",
  }
end

M.setup = function()
  vim.api.nvim_set_keymap(
    "n",
    "<leader>sd",
    ":lua require('rmagatti.telescope.dotfiles').search_dotfiles()<CR>",
    { noremap = true }
  )
end

return M
