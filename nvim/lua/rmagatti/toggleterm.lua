require("toggleterm").setup {
  open_mapping = [[<C-\>]],
  size = function(term)
    if term.direction == "horizontal" then
      return 25
    elseif term.direction == "vertical" then
      return 80
    end
  end,
  start_in_insert = false,
  insert_mappings = true,
}

if vim.g.neovide then
  vim.keymap.set("n", "<D-j>", "<cmd>ToggleTerm<CR>", { noremap = true })
  vim.keymap.set("t", "<D-j>", "<cmd>ToggleTerm<CR>", { noremap = true })
end
