local search_dotfiles = function()
  require('telescope.builtin').find_files {
    prompt_title = "Dotfiles",
    cwd = "~/Projects/dotfiles/nvim"
  }
end

require('vimp').nnoremap('<leader>oiv', search_dotfiles)

