require("goto-preview").setup({
	default_mappings = true,
	resizing_mappings = true,
	winblend = 10,
	debug = false,
	post_open_hook = function()
		vim.cmd([[nnoremap <buffer> q :q<CR>]])
	end,
})
-- Mapping to cycle between windows
vim.cmd([[nnoremap <C-h> <C-w>w]])
