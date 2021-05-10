local packer = require('packer')
return packer.startup(function()
  local use = packer.use
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround' }
  use { 'HerringtonDarkholme/yats.vim' }
  use { 'jparise/vim-graphql' }
  use { 'dbeniamine/cheat.sh-vim' }
  use { 'mbbill/undotree' }
  use { 'jremmen/vim-ripgrep' }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('rmagatti.nvim-web-devicons')
    end
  }
  use { 'vim-test/vim-test' }
  use { 'windwp/nvim-autopairs', config = function()
    require('rmagatti.nvim-autopairs')
  end }
  use { 'justinmk/vim-dirvish' }
  use { 'justinmk/vim-sneak' }
  use { 'mhinz/vim-startify' }
  use { 'unblevable/quick-scope' }
  use { 'tommcdo/vim-exchange' }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'roginfarrer/vim-dirvish-dovish', branch = 'main', requires = {'justinmk/vim-dirvish'} }
  use { 'michaeljsmith/vim-indent-object' }
  use { 'mg979/vim-visual-multi', branch = 'master' }
  -- use { 'heavenshell/vim-jsdoc' }, {'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'kabouzeid/nvim-lspinstall', requires = {'neovim/nvim-lspconfig'}, config = function()
    require('rmagatti.lsp')
  end }

  -- Completion
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('rmagatti.nvim-compe')
    end
  }

  -- Diagnostics
  use {
    'folke/lsp-trouble.nvim',
    config = function()
      require("trouble").setup()
      vim.cmd[[nnoremap <leader>xx <cmd>LspTroubleToggle<CR>]]
    end
  }
  use { 'kosayoda/nvim-lightbulb', config = function() require('rmagatti.nvim-lightbulb') end }

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

  -- Git
  use {
    { 'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'} },
    {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function() require('rmagatti.gitsigns') end,
      event = 'BufEnter'
    },
    { 'TimUntersberger/neogit', opt = true },
    { 'kristijanhusak/vim-dirvish-git', opt = true, requires = {'justinmk/vim-dirvish'}, event = "BufEnter" }
  }
  use { 'sindrets/diffview.nvim', config = function() require('rmagatti.diffview') end }
  use {
    'ThePrimeagen/git-worktree.nvim',
    requires = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('telescope').load_extension("git_worktree")
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
    {
      'nvim-treesitter/playground',
      requires = {'nvim-treesitter/nvim-treesitter'},
      cmd = "TSPlaygroundToggle"
    }
  }
  -- Rainbow parentheses
  use { 'p00f/nvim-ts-rainbow' }

  -- Fzf
  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use { 'junegunn/fzf.vim' }
  use { 'yuki-ycino/fzf-preview.vim', branch = 'release/rpc' }

  -- Lualine
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}, config = function()
    require('rmagatti.lualine')
  end }

  -- Terraform
  use { 'hashivim/vim-terraform' }

  -- Text objects
  use { 'wellle/targets.vim' }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {'nvim-treesitter/nvim-treesitter' },
    after = {'nvim-treesitter'}
  }

  -- Symbols
  use { 'simrat39/symbols-outline.nvim', config = function()
    require('symbols-outline').setup {
      highlight_hovered_item = true,
      show_guides = true,
    }
  end }

  -- Typescript utils
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
  use {'heavenshell/vim-jsdoc', ft = { 'javascript', 'javascript.jsx','typescript' }, run='make install' }

  -- Quickfix enhancements
  use { 'kevinhwang91/nvim-bqf' }

  -- Aligning
  use { 'junegunn/vim-easy-align', config = function() require('rmagatti.easyalign') end }

  -- DAP
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require('telescope').load_extension('dap')
      require('rmagatti.dap')
    end
  }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'nvim-telescope/telescope-dap.nvim', requires = {'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim'} }


  -- Bufferize commands
  use { 'AndrewRadev/bufferize.vim' }

  -- Focus
  use { 'junegunn/goyo.vim', cmd = {'Goyo'} }
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
