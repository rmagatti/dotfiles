local packer = require('packer')
return packer.startup(function()
  local use = packer.use
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround' }
  use { 'HerringtonDarkholme/yats.vim' }
  use { 'jparise/vim-graphql' } -- TODO: remove me? What do I need this for?
  use {
    'dbeniamine/cheat.sh-vim',
    keys = {'n', '<leader>KB', 'n', '<leader>KK', 'n', '<leader>KP'},
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
  use { 'jremmen/vim-ripgrep' }
  use {
    'mhinz/vim-grepper',
    config = function()
      vim.cmd[[
        nmap gs <plug>(GrepperOperator)
        xmap gs <plug>(GrepperOperator)
      ]]
    end
  }

  use {
    'tpope/vim-repeat'
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('rmagatti.nvim-web-devicons')
    end
  }
  use { 'vim-test/vim-test' }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('rmagatti.nvim-autopairs')
    end
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
    requires = {'justinmk/vim-dirvish'}
  }
  use {
    'kristijanhusak/vim-dirvish-git',
    opt = true,
    requires = {'justinmk/vim-dirvish'}
  }

  use {
    'justinmk/vim-sneak',
    keys = {'n', 's', 'n', 'S'}
  }
  use { 'mhinz/vim-startify' }
  use { 'unblevable/quick-scope' }
  use {
    'tommcdo/vim-exchange',
    keys = {'n', 'cx'}
  }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'michaeljsmith/vim-indent-object' }
  use { 'mg979/vim-visual-multi', branch = 'master' }
  -- use { 'heavenshell/vim-jsdoc' }, {'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }

  -- LSP
  use {
    'neovim/nvim-lspconfig'
  }
  use {
    'kabouzeid/nvim-lspinstall',
    requires = {'neovim/nvim-lspconfig'},
    config = function()
      require('rmagatti.lsp-server-configs')
    end,
    after = 'nvim-lspconfig'
  }

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require'lsp_signature'.on_attach {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        -- If you want to hook lspsaga or other signature handler, pls set to false
        -- doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

        hint_enable = true, -- virtual hint enable
        hint_prefix = "🐼 ",  -- Panda for parameter
        hint_scheme = "String",

        handler_opts = {
          border = "shadow"   -- double, single, shadow, none
        },
        -- decorator = {"`", "`"}  -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help

      }
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('rmagatti.nvim-compe')
    end
  }

  -- Lua plugin dev
  use {
    "folke/lua-dev.nvim"
  }

  use { 'svermeulen/vimpeccable' }

  -- Snippets
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'rafamadriz/friendly-snippets' }

  -- Telescope
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      require('rmagatti.telescope')
    end,
    opt = false
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    requires = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('telescope').load_extension('fzf')
    end,
  }
  use {
    'gbrlsnchs/telescope-lsp-handlers.nvim',
    config = function()
      require('telescope').load_extension('lsp_handlers')
    end,
  }

  use {
    'nvim-telescope/telescope-packer.nvim',
    config = function()
      require('telescope').load_extension('packer')
      vim.cmd[[nnoremap <leader>pl :lua require('telescope').extensions.packer.plugins()<CR>]]
    end,
    keys = {'n', '<leader>pl'}
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
    end
  }
  -- use { 'kosayoda/nvim-lightbulb', config = function() require('rmagatti.nvim-lightbulb') end }


  -- Git
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
      'n', '<leader>gd',
      'n', '<leader>gb',
      'n', '<leader>hp',
      'n', '<leader>hs',
      'n', '<leader>hu',
      'n', '<leader>hr',
      'n', '<leader>hR',
      'n', '<leader>hp',
      'n', '<leader>hb',
    }
  }

  use {
    'TimUntersberger/neogit',
    opt = true,
    cmd = {'Neogit'},
    config = function()
      require('neogit').setup{
        integrations = {
          diffview = true
        }
      }
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
  use {
    'ThePrimeagen/git-worktree.nvim',
    requires = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('telescope').load_extension("git_worktree")
      vim.cmd[[nnoremap <leader>wt <cmd>Telescope git_worktree git_worktrees<CR>]]
    end,
    keys = '<leader>wt'
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('rmagatti.gitsigns')
    end
  }

  -- Themes
  -- use { 'gruvbox-community/gruvbox' }
  use { 'folke/tokyonight.nvim', config = function() require('rmagatti.tokyonight') end }

  -- Tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    config = function()
      require('rmagatti.treesitter')
    end,
  }

  use {
    'nvim-treesitter/playground',
    requires = {'nvim-treesitter/nvim-treesitter'},
    cmd = "TSPlaygroundToggle"
  }

  -- Rainbow parentheses
  use {
    'p00f/nvim-ts-rainbow'
  }

  -- Fzf
  use {
    'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end
  }
  use { 'junegunn/fzf.vim' }
  use { 'yuki-ycino/fzf-preview.vim', branch = 'release/rpc' }

  -- Lualine
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}, config = function()
    require('rmagatti.lualine')
  end }

  -- Terraform
  use {
    'hashivim/vim-terraform',
    ft = {'terraform'}
  }

  -- Text objects
  use { 'wellle/targets.vim' }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {'nvim-treesitter/nvim-treesitter' },
    after = {'nvim-treesitter'}
  }

  -- Symbols
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup {
        highlight_hovered_item = true,
        show_guides = true,
      }
    end
  }

  -- Typescript utils
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = {'neovim/nvim-lspconfig'},
    config = function()
      require('rmagatti.nvim-lsp-ts-utils')
    end,
    after = 'nvim-lspinstall'
  }

  use {'heavenshell/vim-jsdoc', ft = { 'javascript', 'javascript.jsx','typescript' }, run='make install' }

  -- Quickfix enhancements
  use {
    'kevinhwang91/nvim-bqf',
    disable = false
  }

  -- Aligning
  use { 'junegunn/vim-easy-align', config = function() require('rmagatti.easyalign') end }

  -- DAP
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('telescope').load_extension('dap')
      require('rmagatti.dap')
    end,
    keys = {'n', '<leader>db', 'n', '<leader>dB'}
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
    after = 'nvim-dap'
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
    branch = 'lua'
  }

  -- Bufferize commands
  use {
    'AndrewRadev/bufferize.vim',
    cmd = {'Bufferize'}
  }

  -- Focus
  use {
    'junegunn/goyo.vim',
    cmd = {'Goyo'},
    config = function()
      vim.cmd[[
      let g:goyo_width=120
      let g:goyo_height=90
      nnoremap <leader>zz :Goyo
      ]]
    end,
    keys = '<leader>zz'
  }
  use { 'junegunn/limelight.vim', cmd = {'Limelight'} }

  -- Profiling
  use {'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]]}

  -- Local
  use {
    '~/Projects/auto-session',
    as = 'auto-session',
    config = function()
      require('rmagatti.auto-session')
    end
  }

  use {
    '~/Projects/alternate-toggler',
    as = 'alternate-toggler'
  }
  use {
    '~/Projects/session-lens',
    as = 'session-lens',
    requires = {{'~/Projects/auto-session'}, {'nvim-telescope/telescope.nvim'}},
    config = function()
      require('rmagatti.session-lens')
    end
  }
end)
