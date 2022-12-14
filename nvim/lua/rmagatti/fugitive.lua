local M = {}

M.setup = function()
  vim.cmd [[
    nnoremap <silent> <leader>gb :<C-u>Git blame<CR>
    nnoremap <silent> gb :<C-u>Git blame<CR>
    nnoremap <leader>gd :Gvdiffsplit!<CR>
    nnoremap gj :diffget //2<CR>
    nnoremap g; :diffget //3<CR>
  ]]

  vim.keymap.set("n", "<leader>gb", ":<C-u>Git blame<CR>", { silent = true })
  vim.keymap.set("n", "gb", ":<C-u>Git blame<CR>", { silent = true })
  vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", { silent = true })
  vim.keymap.set("n", "gj", ":diffget //2<CR>", { silent = true })
  vim.keymap.set("n", "g;", ":diffget //3<CR>", { silent = true })

  vim.keymap.set("n", "<leader>gh", ":0Gclog<CR>", { silent = true })
end

return M
