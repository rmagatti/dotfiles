vim.keymap.set(
  "n",
  "<D-f>",
  function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())
  end,
  { desc = "Current buffer fuzzy find" }
)

vim.keymap.set("n", "<C-p>", function()
  local success, _ = pcall(require("telescope.builtin").git_files)
  if not success then
    require("telescope.builtin").find_files()
    return
  end
end, {})

vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<leader>ps", require("telescope.builtin").live_grep, {})
vim.keymap.set(
  "n",
  "<leader>pg",
  "<cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input('Search: ')})<CR>",
  {}
)

vim.keymap.set("n", "<localleader>cm", require("telescope.builtin").commands, { desc = "Search Vim commands" })
vim.keymap.set("n", "<localleader>tgs", require("telescope.builtin").tags, { desc = "Search tags" })
vim.keymap.set("n", "<localleader>cmh", require("telescope.builtin").command_history, { desc = "Search command history" })
vim.keymap.set("n", "<leader>/", require("telescope.builtin").search_history, { desc = "Search Vim search history" })
vim.keymap.set("n", "<localleader>ht", require("telescope.builtin").help_tags, { desc = "Search help tags" })
vim.keymap.set("n", "<localleader>mp", require("telescope.builtin").man_pages, { desc = "Search man pages" })
vim.keymap.set("n", "<localleader>ma", require("telescope.builtin").marks, { desc = "Jump to marks" })
vim.keymap.set("n", "<localleader>cs", require("telescope.builtin").colorscheme, { desc = "Change colorscheme" })
vim.keymap.set("n", "<localleader>qs", require("telescope.builtin").quickfix, { desc = "Open quickfix list" })
vim.keymap.set("n", "<localleader>qh", require("telescope.builtin").quickfixhistory, { desc = "Open quickfix history" })
vim.keymap.set("n", "<localleader>ll", require("telescope.builtin").loclist, { desc = "Open location list" })
vim.keymap.set("n", "<localleader>jl", require("telescope.builtin").jumplist, { desc = "Jump to locations in jump list" })
vim.keymap.set("n", "<localleader>vo", require("telescope.builtin").vim_options, { desc = "Search Vim options" })
vim.keymap.set("n", "<localleader>re", require("telescope.builtin").registers, { desc = "Search registers" })
vim.keymap.set("n", "<localleader>ac", require("telescope.builtin").autocommands, { desc = "Search autocommands" })
vim.keymap.set("n", "<localleader>ss", require("telescope.builtin").spell_suggest, { desc = "Search spell suggestions" })
vim.keymap.set("n", "<localleader>km", require("telescope.builtin").keymaps, { desc = "Search key mappings" })
vim.keymap.set("n", "<localleader>ft", require("telescope.builtin").filetypes, { desc = "Search file types" })
vim.keymap.set("n", "<localleader>hl", require("telescope.builtin").highlights, { desc = "Search syntax highlights" })
vim.keymap.set("n", "<localleader>/",
  function() require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown()) end,
  { desc = "Find in current buffer" })
vim.keymap.set("n", "<localleader>bt", require("telescope.builtin").current_buffer_tags,
  { desc = "Search tags in current buffer" })
vim.keymap.set("n", "<localleader>res", require("telescope.builtin").resume, { desc = "Resume last Telescope session" })
vim.keymap.set("n", "<localleader>p", require("telescope.builtin").pickers, { desc = "Open Telescope pickers" })
vim.keymap.set("n", "<localleader>r", require("telescope.builtin").lsp_references, { desc = "Search LSP references" })
vim.keymap.set("n", "<localleader>ic", require("telescope.builtin").lsp_incoming_calls,
  { desc = "Search LSP incoming calls" })
vim.keymap.set("n", "<localleader>oc", require("telescope.builtin").lsp_outgoing_calls,
  { desc = "Search LSP outgoing calls" })
vim.keymap.set("n", "<localleader>ds", require("telescope.builtin").lsp_document_symbols,
  { desc = "Search LSP document symbols" })
vim.keymap.set("n", "<localleader>wsd",
  function() require("telescope.builtin").lsp_dynamic_workspace_symbols { file_ignore_patterns = { "node_modules/**" } } end,
  { desc = "Search LSP dynamic workspace symbols" })
vim.keymap.set("n", "<localleader>ws", require("telescope.builtin").lsp_workspace_symbols,
  { desc = "Search LSP workspace symbols" })
vim.keymap.set("n", "<localleader>di", require("telescope.builtin").diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<localleader>i", require("telescope.builtin").lsp_implementations,
  { desc = "Search LSP implementations" })
vim.keymap.set("n", "<localleader>ld", require("telescope.builtin").lsp_definitions, { desc = "Search LSP definitions" })
vim.keymap.set("n", "<localleader>td", require("telescope.builtin").lsp_type_definitions,
  { desc = "Search LSP type definitions" })
vim.keymap.set("n", "<localleader>gbc", require("telescope.builtin").git_bcommits, { desc = "Search git buffer commits" })
vim.keymap.set("n", "<localleader>gc", require("telescope.builtin").git_commits, { desc = "Search git commits" })
vim.keymap.set("n", "<localleader>gB", require("telescope.builtin").git_branches, { desc = "Search git branches" })
vim.keymap.set("n", "<localleader>gs", require("telescope.builtin").git_status, { desc = "View git status" })
vim.keymap.set("n", "<localleader>gst", require("telescope.builtin").git_stash, { desc = "Search git stash" })
vim.keymap.set("n", "<localleader>t", require("telescope.builtin").treesitter, { desc = "Search Treesitter symbols" })

vim.keymap.set("n", "<localleader>ws", require("telescope.builtin").lsp_workspace_symbols, { desc = "Workspace Symbols" })
vim.keymap.set("n", "<localleader>di", require("telescope.builtin").diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<localleader>i", require("telescope.builtin").lsp_implementations, { desc = "LSP Implementations" })
vim.keymap.set("n", "<localleader>ld", require("telescope.builtin").lsp_definitions, { desc = "LSP Definitions" })
vim.keymap.set("n", "<localleader>td", require("telescope.builtin").lsp_type_definitions,
  { desc = "LSP Type Definitions" })
vim.keymap.set("n", "<localleader>gbc", require("telescope.builtin").git_bcommits, { desc = "Git Buffer Commits" })
vim.keymap.set("n", "<localleader>gc", require("telescope.builtin").git_commits, { desc = "Git Commits" })
vim.keymap.set("n", "<localleader>gB", require("telescope.builtin").git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<localleader>gs", require("telescope.builtin").git_status, { desc = "Git Status" })
vim.keymap.set("n", "<localleader>gst", require("telescope.builtin").git_stash, { desc = "Git Stash" })
vim.keymap.set("n", "<localleader>t", require("telescope.builtin").treesitter, { desc = "Treesitter" })

--- Search for file from path under cursor using Telescope
vim.keymap.set('n', 'gt', function()
  local line = vim.fn.getline('.')
  local file_path = line:match('([^:]+):%d+:%d+')

  if file_path then
    -- Remove any leading './' from the path
    file_path = file_path:gsub('^%./', '')

    -- Store the cleaned path in a variable
    vim.g.last_extracted_path = file_path

    -- Try git_files first, fall back to find_files (same logic as your <C-p> mapping)
    local success, _ = pcall(function()
      require("telescope.builtin").git_files({
        default_text = file_path,
        initial_mode = "insert"
      })
    end)

    if not success then
      require("telescope.builtin").find_files({
        default_text = file_path,
        initial_mode = "insert"
      })
    end
  else
    print("No file path found in current line")
  end
end, { noremap = true, silent = true, desc = "Open file from path under cursor using Telescope" })
