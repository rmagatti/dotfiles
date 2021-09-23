local packer = require('packer')
return packer.startup {function(use)
  use {
    'wbthomason/packer.nvim',
    -- commit = '8bee5e4ce13691fcb040eced2a219e637b7ef1a1',
  }
  use {
   'tpope/vim-commentary',
  }

  -- TODO: trying this out. Faster startup for "free" but I'm skeptical that it wouldn't cause any issues for now.
  use {
   'lewis6991/impatient.nvim',
  }


  use {
   'tpope/vim-surround',
   keys = {
     {'n', 'cs'},
     {'n', 'ds'},
     {'x', 'S'},
     {'n', 'ys'}
   }
  }

  use {
    'tpope/vim-repeat'
  }

  use {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup {
        open_mapping = [[<c-\>]],
        size = function(term)
          if term.direction == "horizontal" then
            return 25
          elseif term.direction == "vertical" then
            return 80
          end
        end,
        start_in_insert = false,
        insert_mappings = true
      }

      vim.api.nvim_set_keymap('n', [[<leader>2s]], "<cmd>2ToggleTerm direction='horizontal'<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', [[<leader>3s]], "<cmd>3ToggleTerm direction='horizontal'<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', [[<leader>4s]], "<cmd>4ToggleTerm direction='horizontal'<CR>", {noremap = true})

      vim.api.nvim_set_keymap('n', [[<leader>2v]], "<cmd>2ToggleTerm direction='vertical'<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', [[<leader>3v]], "<cmd>3ToggleTerm direction='vertical'<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', [[<leader>4v]], "<cmd>4ToggleTerm direction='vertical'<CR>", {noremap = true})

    end,
    keys = {
      {'n', [[<C-\>]]},
      {'i', [[<C-\>]]},
      {'n', [[<leader>2s]]},
      {'n', [[<leader>3s]]},
      {'n', [[<leader>4s]]},
      {'n', [[<leader>2v]]},
      {'n', [[<leader>3v]]},
      {'n', [[<leader>4v]]},
    },
    cmd = {'ToggleTerm', 'ToggleTermOpenAll', 'ToggleTermCloseAll'}
  }

  ----==== Lazy loaded

  use {
    'dbeniamine/cheat.sh-vim',
    keys = {
      {'n', '<leader>KB'},
      {'n', '<leader>KK'},
      {'n', '<leader>KP'},
    },
    cmd = {'Cheat', 'CheatPaste'}
  }
  use {
    'mbbill/undotree',
    config = function()
      vim.cmd[[nnoremap <leader>u :UndotreeShow<CR>]]
    end,
    keys = '<leader>u'
  }

   -- Grepping
  use {
   'jremmen/vim-ripgrep',
   cmd = { 'Rg' }
  }
  use {
    'mhinz/vim-grepper',
    config = function()
      vim.cmd[[
        nmap gs <Plug>(GrepperOperator)
        xmap gs <Plug>(GrepperOperator)
      ]]
    end,
    cmd = {'Grepper', '<Plug>(GrepperOperator)'},
    keys = {
      {'n', 'gs'},
      {'x', 'gs'}
    }
  }

   use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('rmagatti.nvim-web-devicons')
    end,
    module = 'nvim-web-devicons'
  }

  use {
   'vim-test/vim-test',
   config = function()
    vim.cmd[[
      let g:test#javascript#mocha#file_pattern = '\v(tests?/.*|(test))\.(js|jsx|coffee|ts)$'
      let test#javascript#mocha#executable = 'yarn test'
      let test#javascript#jest#executable = 'yarn test'

      function! DebugStrategy(cmd)
        let runner = test#determine_runner(expand('%'))
        call luaeval("require('rmagatti.dap').debug")(runner, a:cmd)
      endfunction

      function! SplitStrategy(cmd)
        vertical new | call termopen(a:cmd)
      endfunction
      let g:test#custom_strategies = {'terminal_split': function('SplitStrategy'), 'debug': function('DebugStrategy')}
      let g:test#strategy = 'terminal_split'

      " Regular mappings
      nmap <leader>tt :TestNearest<CR>
      nmap <leader>tf :TestFile<CR>
      nmap <leader>ts :TestSuite<CR>
      nmap <leader>tl :TestLast<CR>
      nmap <leader>tv :TestVisit<CR>

      " Debug mappings
      nmap <leader>tdt :TestNearest -strategy=debug<CR>
      nmap <leader>tdf :TestFile -strategy=debug<CR>
      nmap <leader>tds :TestSuite -strategy=debug<CR>
      nmap <leader>tdl :TestLast -strategy=debug<CR>
      nmap <leader>tdv :TestVisit -strategy=debug<CR>
    ]]
   end,
   keys = {
     {'n', '<leader>tf'},
     {'n', '<leader>tt'},
     {'n', '<leader>ts'},
     {'n', '<leader>tf'},
     {'n', '<leader>tt'},
     {'n', '<leader>tf'},
     {'n', '<leader>ts'},
     {'n', '<leader>tl'},
     {'n', '<leader>tv'},
     {'n', '<leader>tdt'},
     {'n', '<leader>tdf'},
     {'n', '<leader>tds'},
     {'n', '<leader>tdl'},
     {'n', '<leader>tdv'},
   }
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('rmagatti.nvim-autopairs')
    end,
    event = "InsertEnter"
  }

  use {
    'justinmk/vim-dirvish',
    config = function ()
      vim.cmd[[
      command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish
      command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %
      nnoremap <leader>fs :VLeftDirvish<CR>
      nnoremap <leader>ff :VLeftDirvishFile<CR>
      ]]
    end
  }
  use {
    'roginfarrer/vim-dirvish-dovish',
    branch = 'main',
    requires = {'justinmk/vim-dirvish'},
    config = function ()
      vim.cmd[[
        let g:dirvish_dovish_map_keys = 0

        augroup dirvish_config
        autocmd!
        " unmap dirvish default
        autocmd FileType dirvish silent! unmap <buffer><C-p>
        autocmd FileType dirvish silent! unmap <buffer>p

        " My mappings
        autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)
        autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)
        autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)
        autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)
        autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
        autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
        autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)
        autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)
        augroup END
      ]]
    end
  }

  use {
    'kristijanhusak/vim-dirvish-git',
    opt = true,
    requires = {'justinmk/vim-dirvish'}
  }

  use {
    'ggandor/lightspeed.nvim',
    config = function ()
      require('lightspeed').setup {
        jump_to_first_match = true,
        jump_on_partial_input_safety_timeout = 400,
        highlight_unique_chars = false,
        grey_out_search_area = true,
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
        full_inclusive_prefix_key = '<c-x>',
      }
    end,
    module = {'lightspeed'},
    keys = {
      {'n', 's'},
      {'n', 'S'},
      {'n', 'f'},
      {'n', 'F'},
    }
  }

  use {
    'vimwiki/vimwiki',
    branch = 'dev',
    setup = function()
        -- let gwiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}
      vim.cmd("let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes':{'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}}]")
      vim.cmd[[
        let g:vimwiki_listsyms = '✗○◐●✓'
      ]]
    end,
    keys = {
      {'n', '<leader>ww'},
      {'n', '<leader>wi'},
      {'n', '<leader>w<leader>w'},
      {'n', '<leader>ws'},
    },
    ft = {'vimwiki', 'markdown'},
  }

  use {
    'tommcdo/vim-exchange',
    keys = {
      {'n', 'cx'},
      {'x', 'X'}
    }
  }

  --use {
  --  'glacambre/firenvim',
  --  run = function()
  --    vim.fn['firenvim#install'](0)
  --  end,
  --  module = 'firenvim',
  --  config = function ()
  --    vim.cmd[[
  --      let g:firenvim_config = {'globalSettings': {'alt': 'all', },'localSettings': {'.*': {'cmdline': 'neovim','content': 'text','priority': 0,'selector': 'textarea','takeover': 'never'}}}
  --      let fc = g:firenvim_config['localSettings']
  --      let fc['https?://docs.google.com/spreadsheets/'] = { 'takeover': 'never', 'priority': 1 }
  --      let fc['https?://meet.google.com/'] = { 'takeover': 'never', 'priority': 1 }
  --    ]]
  --  end
  --}

  -- TODO: do I really use this?
  --use {
  -- 'michaeljsmith/vim-indent-object',
  -- event = 'BufReadPost'
  --}

  use {
    'mg979/vim-visual-multi',
    branch = 'master',
    keys = '<C-n>'
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    module = 'lspconfig'
  }

  use {
    'kabouzeid/nvim-lspinstall',
    requires = {'neovim/nvim-lspconfig'},
    config = function()
      require('rmagatti.lsp-server-configs')
    end,
    event = 'BufReadPost',
    after = 'nvim-lspconfig'
  }

  use {
    "ray-x/lsp_signature.nvim",
    module = {'lsp_signature'}
  }

   -- Completion
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('rmagatti.nvim-compe')
    end,
    module = {'compe'},
    event = "BufReadPre"
  }

  -- Lua plugin dev
  use {
    "folke/lua-dev.nvim",
    module = "lua-dev",
    ft = 'lua'
  }

  use {
    'svermeulen/vimpeccable'
  }

  -- -- Snippets
  use {
    'hrsh7th/vim-vsnip',
    event = {'BufReadPre'}
  }
  use {
    'hrsh7th/vim-vsnip-integ',
    event = {'BufReadPre'}
  }
  use {
    'rafamadriz/friendly-snippets',
    event = {'BufReadPre'}
  }

  -- -- Telescope
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      require('rmagatti.telescope')
    end,
    cmd = "Telescope",
		module = {'telescope'}
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    requires = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('telescope').load_extension('fzf')
    end,
    after = 'telescope.nvim'
  }

  use {
    '~/Projects/telescope-lsp-handlers.nvim',
    requires = {'telescope.nvim'},
    config = function()
      require('telescope').load_extension('lsp_handlers')
    end,
    after = 'telescope.nvim'
  }

  use {
    'nvim-telescope/telescope-packer.nvim',
    config = function()
      require('telescope').load_extension('packer')
      vim.cmd[[nnoremap <leader>pl :lua require('telescope').extensions.packer.plugins()<CR>]]
    end,
    keys = '<leader>pl'
  }

  -- Diagnostics
  use {
    'folke/lsp-trouble.nvim',
    config = function()
      require("trouble").setup()
      vim.cmd[[nnoremap <leader>xx <cmd>LspTrouble<CR>]]
    end,
    keys = '<leader>xx',
    cmd = {'LspTrouble'}
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
    cmd = { 'TodoQuickFix', 'TodoTrouble', 'TodoTelescope' }
  }

  use {
    'kosayoda/nvim-lightbulb',
    config = function()
      require('rmagatti.nvim-lightbulb')
    end,
    event = 'BufReadPost'
  }

  ---- Git
  use {
    'tpope/vim-fugitive',
    cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gvdiffsplit'},
    config = function ()
      vim.cmd[[
        nnoremap <silent> <leader>gb :<C-u>Git blame<CR>
        nnoremap <leader>gd :Gvdiffsplit!<CR>
        nnoremap gj :diffget //2<CR>
        nnoremap g; :diffget //3<CR>
        ]]
    end,
    keys = {
      {'n', '<leader>gd'},
      {'n', '<leader>gb'},
      {'n', '<leader>hp'},
      {'n', '<leader>hs'},
      {'n', '<leader>hu'},
      {'n', '<leader>hr'},
      {'n', '<leader>hR'},
      {'n', '<leader>hp'},
      {'n', '<leader>hb'},
    }
  }

  use {
    'TimUntersberger/neogit',
    opt = true,
    cmd = {'Neogit'},
    keys = {
      {'n', '<leader>gg'}
    },
    config = function()
      require('neogit').setup{
        integrations = {
          diffview = true
        }
      }
      vim.cmd[[nnoremap <leader>gg <cmd>Neogit<CR>]]
    end
  }

  use {
    'sindrets/diffview.nvim',
    config = function()
      require('rmagatti.diffview')
    end,
    cmd = {'DiffviewOpen'},
    keys = '<leader>ddo'
  }

  -- use {
  --   'ThePrimeagen/git-worktree.nvim',
  --   requires = {'nvim-telescope/telescope.nvim'},
  --   config = function()
  --     require('telescope').load_extension("git_worktree")
  --     vim.cmd[[nnoremap <leader>wt <cmd>Telescope git_worktree git_worktrees<CR>]]
  --   end,
  --   keys = '<leader>wt'
  -- }

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    },
    config = function()
      require('rmagatti.refactoring')
    end,
    keys = {
      {'v', '<leader>re'}
    }
  }

  -- Themes
  -- use { 'gruvbox-community/gruvbox' }
  use {
    'folke/tokyonight.nvim',
    config = function()
      require('rmagatti.tokyonight')
    end
  }

  -- Tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter', -- TODO: lazy load me! (maybe)
    run = ':TSUpdate',
    config = function()
      require('rmagatti.treesitter')
    end
  }

--   -- TODO: uncomment me!!!

  use {
    'nvim-treesitter/playground',
    requires = {'nvim-treesitter/nvim-treesitter'},
    cmd = "TSPlaygroundToggle"
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
  }

  -- Rainbow parentheses
  use {
    'p00f/nvim-ts-rainbow'
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {'nvim-treesitter/nvim-treesitter' },
    event = {'BufReadPost'}
  }

  use {
    'RRethy/nvim-treesitter-textsubjects',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    event = {'BufReadPost'}
  }

-- GitHub
  use  {
    'pwntester/octo.nvim',
    config = function()
      require"octo".setup()
    end,
    cmd = {'Octo'}
  }

use {
  'lewis6991/gitsigns.nvim',
  requires = {'nvim-lua/plenary.nvim'},
  config = function()
    require('rmagatti.gitsigns')
  end,
  event = "BufRead"
}

  -- Fzf
  use {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
    event = {'BufReadPost'}
  }
  use {
    'junegunn/fzf.vim',
    requires = 'junegunn/fzf',
    after = {'nvim-bqf'}
  }

  -- Lualine
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}, config = function()
    require('rmagatti.lualine')
  end }


  -- TODO: table index is null issue when this is enabled
  -- use {
  --   'nvim-lua/lsp-status.nvim',
  -- }

  -- Terraform
  use {
    'hashivim/vim-terraform',
    disable = false,
    ft = {'terraform'}
  }

  -- Text objects
  use {
    'wellle/targets.vim',
    event = {'BufReadPost'}
  }

  -- Symbols
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup {
        highlight_hovered_item = true,
        show_guides = true,
      }
    end,
    cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}
  }

  -- Typescript utils
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup {}
    end,
    module = {'null-ls'}
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = {'neovim/nvim-lspconfig', 'jose-elias-alvarez/null-ls.nvim'},
    config = function()
      require('rmagatti.nvim-lsp-ts-utils')
    end,
    after = 'nvim-lspinstall'
  }

  use {
    'heavenshell/vim-jsdoc',
    ft = { 'javascript', 'javascript.jsx', 'typescript' },
    cmd = 'JsDoc',
    run='make install'
  }

  -- Quickfix enhancements
  use {
    'kevinhwang91/nvim-bqf',
    requires = {{'junegunn/fzf', opt = true}, {'junegunn/fzf.vim', opt = true}},
    ft = {'qf'},
    config = function()
      require('bqf').setup {
        auto_enable = true
      }
    end
  }

  -- Aligning
  use {
    'junegunn/vim-easy-align',
    config = function()
      require('rmagatti.easyalign')
    end,
    cmd = { 'EasyAlign' }
  }

  -- DAP
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('telescope').load_extension('dap')
      require('rmagatti.dap')
    end,
    keys = {{'n', '<leader>db'}, {'n', '<leader>dB'}}
  }
  use {
    'theHamsta/nvim-dap-virtual-text',
    after = 'nvim-dap'
  }
  use {
    'nvim-telescope/telescope-dap.nvim',
    requires = {'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension('dap')
    end,
    after = 'nvim-dap',
    module = 'telescope._extensions.dap'
  }

  -- WhichKey
  use {
    "folke/which-key.nvim",
    config = function()
      require('rmagatti.which-key')
    end
  }

  -- Indent Blankline
  use {
    'lukas-reineke/indent-blankline.nvim',
    event = {'InsertEnter'},
    setup = function()
      vim.g.indent_blankline_buftype_exclude = {"terminal"}
      vim.g.indent_blankline_filetype_exclude = {"toggleterm"}
    end
  }

  -- Bufferize commands
  use {
    'AndrewRadev/bufferize.vim',
    cmd = {'Bufferize'}
  }

  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = {
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = true,
            font = "+4", -- font size increment
          },
        }
      }
      vim.cmd[[
        nnoremap <leader>zz :lua require("zen-mode").toggle({ window = { width = .40 }})<CR>
      ]]
    end,
    keys = '<leader>zz'
  }

  -- TODO: learn to use!!!
  -- use {
  --   'kristijanhusak/orgmode.nvim',
  --   disable = true,
  --   config = function()
  --     require('orgmode').setup{
  --       org_agenda_file = '~/Documents/org/*',
  --       org_default_notes_file = '~/Documents/org/refile.org',
  --     }
  --   end,
  --   module = 'orgmode',
  --   ft = 'org',
  --   keys = {
  --     {'n', '<leader>oa'} -- TODO: this is supposed to be 'open alternate'. Really don't like this current mapping.
  --   }
  -- }

  -- Profiling
  use {'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]]}

  use {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('neoclip').setup()
      vim.cmd[[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
    end,
    keys = {
      {'n', '<leader>y'}
    }
  }

  -- Local
  use {
    '~/Projects/auto-session',
    config = function()
      require('rmagatti.auto-session')
    end
  }

  use {
    '~/Projects/alternate-toggler',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader><space>', "<cmd>lua require('alternate-toggler').toggleAlternate(vim.fn.expand('<cword>'))<CR>", {noremap = true})
      vim.cmd[[ let g:at_custom_alternates = {'===': '!=='} ]]
    end,
    event = {'BufReadPost'},
  }

  use {
    '~/Projects/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
        resizing_mappings = true,
        winblend = 10,
        debug = false,
        -- references = {
        --   telescope = require('telescope.themes').get_cursor({hide_preview = false, width=120, height=10})
        -- }
      }
      -- Mapping to cycle between windows
      vim.cmd[[nnoremap <C-h> <C-w>w]]
    end,
    -- keys = {
    --   {'n', 'gpd'},
    --   {'n', 'gpi'},
    --   {'n', 'gpr'},
    --   {'n', 'gP'},
    -- }
  }

  use {
    '~/Projects/session-lens',
    requires = {'~/Projects/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('rmagatti.session-lens')
      require('telescope').load_extension('session-lens')
    end,
    keys = '<leader>ss'
  }

end, config = {
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
}}
