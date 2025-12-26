local Snacks = require("snacks")

-- File pickers
vim.keymap.set("n", "<D-f>", function()
  Snacks.picker.grep_buffers()
end, { desc = "Current buffer fuzzy find" })

vim.keymap.set("n", "<C-p>", function()
  Snacks.picker.git_files()
end, { desc = "Git files" })

vim.keymap.set("n", "<C-f>", function()
  Snacks.picker.files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>ps", function()
  Snacks.picker.grep()
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>pg", function()
  local search = vim.fn.input("Search: ")
  if search ~= "" then
    Snacks.picker.grep({ search = search })
  end
end, { desc = "Grep string" })

-- Vim/Neovim internals
vim.keymap.set("n", "<localleader>cm", function()
  Snacks.picker.commands()
end, { desc = "Search Vim commands" })

vim.keymap.set("n", "<localleader>cmh", function()
  Snacks.picker.command_history()
end, { desc = "Search command history" })

vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.search_history()
end, { desc = "Search Vim search history" })

vim.keymap.set("n", "<localleader>ht", function()
  Snacks.picker.help()
end, { desc = "Search help tags" })

vim.keymap.set("n", "<localleader>mp", function()
  Snacks.picker.man()
end, { desc = "Search man pages" })

vim.keymap.set("n", "<localleader>ma", function()
  Snacks.picker.marks()
end, { desc = "Jump to marks" })

vim.keymap.set("n", "<localleader>cs", function()
  Snacks.picker.colorschemes()
end, { desc = "Change colorscheme" })

vim.keymap.set("n", "<localleader>qs", function()
  Snacks.picker.qflist()
end, { desc = "Open quickfix list" })

vim.keymap.set("n", "<localleader>ll", function()
  Snacks.picker.loclist()
end, { desc = "Open location list" })

vim.keymap.set("n", "<localleader>jl", function()
  Snacks.picker.jumplist()
end, { desc = "Jump to locations in jump list" })

vim.keymap.set("n", "<localleader>vo", function()
  Snacks.picker.vim_options()
end, { desc = "Search Vim options" })

vim.keymap.set("n", "<localleader>re", function()
  Snacks.picker.registers()
end, { desc = "Search registers" })

vim.keymap.set("n", "<localleader>ac", function()
  Snacks.picker.autocmds()
end, { desc = "Search autocommands" })

vim.keymap.set("n", "<localleader>ss", function()
  Snacks.picker.spelling()
end, { desc = "Search spell suggestions" })

vim.keymap.set("n", "<localleader>km", function()
  Snacks.picker.keymaps()
end, { desc = "Search key mappings" })

vim.keymap.set("n", "<localleader>hl", function()
  Snacks.picker.highlights()
end, { desc = "Search syntax highlights" })

vim.keymap.set("n", "<localleader>/", function()
  Snacks.picker.grep_buffers()
end, { desc = "Find in current buffer" })

vim.keymap.set("n", "<localleader>res", function()
  Snacks.picker.resume()
end, { desc = "Resume last picker session" })

-- LSP pickers
vim.keymap.set("n", "<localleader>r", function()
  Snacks.picker.lsp_references()
end, { desc = "Search LSP references" })

vim.keymap.set("n", "<localleader>ds", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Search LSP document symbols" })

vim.keymap.set("n", "<localleader>wsd", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "Search LSP dynamic workspace symbols" })

vim.keymap.set("n", "<localleader>ws", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "Search LSP workspace symbols" })

vim.keymap.set("n", "<localleader>di", function()
  Snacks.picker.diagnostics()
end, { desc = "Search diagnostics" })

vim.keymap.set("n", "<localleader>i", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Search LSP implementations" })

vim.keymap.set("n", "<localleader>ld", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Search LSP definitions" })

vim.keymap.set("n", "<localleader>td", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Search LSP type definitions" })

-- Git pickers
vim.keymap.set("n", "<localleader>gbc", function()
  Snacks.picker.git_log_file()
end, { desc = "Search git buffer commits" })

vim.keymap.set("n", "<localleader>gc", function()
  Snacks.picker.git_log()
end, { desc = "Search git commits" })

vim.keymap.set("n", "<localleader>gB", function()
  Snacks.picker.git_branches()
end, { desc = "Search git branches" })

vim.keymap.set("n", "<localleader>gs", function()
  Snacks.picker.git_status()
end, { desc = "View git status" })

-- Note: git stash is not available in snacks picker
-- You may need to use git commands directly or wait for this feature

-- Treesitter picker (if available in snacks)
-- Note: This may not have a direct equivalent in snacks
-- vim.keymap.set("n", "<localleader>t", function()
--   Snacks.picker.treesitter()
-- end, { desc = "Search Treesitter symbols" })

-- Search for file from path under cursor
vim.keymap.set('n', 'gt', function()
  local line = vim.fn.getline('.')
  local file_path = line:match('([^:]+):%d+:%d+')

  if file_path then
    file_path = file_path:gsub('^%./', '')
    vim.g.last_extracted_path = file_path

    Snacks.picker.git_files({ search = file_path })
  else
    print("No file path found in current line")
  end
end, { noremap = true, silent = true, desc = "Open file from path under cursor" })
