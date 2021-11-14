local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				-- Close on first esc instead of going to normal mode
				["<esc>"] = actions.close,
				["<C-i>"] = require("telescope.actions").cycle_history_next,
				["<C-o>"] = require("telescope.actions").cycle_history_prev,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
			lsp_handlers = {
				code_action = {
					-- FIXME: setting this does not do what it should.
					telescope = require("telescope.themes").get_cursor(),
				},
			},
		},
	},
})

require("rmagatti.telescope.buffers").setup()
require("rmagatti.telescope.dotfiles").setup()

-- Mappings
local nnoremap = function(map, cmd)
	vim.api.nvim_set_keymap("n", map, cmd, { noremap = true })
end

nnoremap(
	"<C-_>",
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())<CR>"
)
nnoremap("<C-p>", "<cmd>lua require('telescope.builtin').git_files()<CR>")
nnoremap("<C-f>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
nnoremap("<leader>ps", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
nnoremap("<leader>pg", "<cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input('Search: ')})<CR>")
nnoremap("<leader>wt", "<cmd>lua require('telescope.extensions').git_worktree.git_worktrees()<CR>")
