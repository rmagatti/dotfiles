local id = vim.api.nvim_create_augroup("NeorgAugroup", { clear = true })

local create_link_from_cword = function()
  local word = vim.fn.expand("<cword>")
  local substitution = string.format("{:%s:}[%s]", word, word)
  vim.cmd(string.format("normal! ciw%s", substitution))
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.norg" },
  group = id,
  callback = function()
    vim.keymap.set("n", "<leader>l", ":Telescope neorg insert_link<CR>", { silent = true, noremap = true, buffer = true })
    vim.keymap.set("n", "<localleader>cl", create_link_from_cword, { silent = true, noremap = true, buffer = true })
  end
})
