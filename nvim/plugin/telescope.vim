" Search sessions
nnoremap <leader>ss <cmd>Telescope session-lens search_session<CR>
nnoremap <leader>wt <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>

nnoremap <leader>ps <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>lua require('rmagatti.buffers').custom_buffers()<CR>
