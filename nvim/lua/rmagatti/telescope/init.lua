local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_ignore_patterns = {},
    shorten_path = true,
    winblend = 0,
    width = 0.25,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        -- Close on first esc instead of gonig to normal mode
        ["<esc>"] = actions.close,
      }
    },
    extensions = {
      fzf = {
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      }
    },
  }
}

require('rmagatti.telescope.buffers')
require('rmagatti.telescope.dotfiles')

-- Mappings
-- nnoremap <leader>wt <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
vim.cmd[[
" Search sessions
nnoremap <leader>ss <cmd>Telescope session-lens search_session<CR>

" Git Worktrees
nnoremap <leader>wt <cmd>Telescope git_worktree git_worktrees<CR>

nnoremap <leader>ps <cmd>Telescope live_grep<CR>
nnoremap <leader>sw <cmd>Telescope grep_string<CR>
nnoremap <leader>b <cmd>lua require('rmagatti.telescope.buffers').custom_buffers()<CR>
]]
