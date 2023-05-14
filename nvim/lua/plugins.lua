local ensure_packer = function()
  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local config = {
  -- compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  -- profile = {
  --   enable = true,
  --   threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  -- }
}

return require("packer").startup {
  function(use)
    use {
      "wbthomason/packer.nvim",
    }

    use { "tpope/vim-commentary" }
    use { "tpope/vim-abolish" }

    use {
      "JoosepAlviste/nvim-ts-context-commentstring",
      before = "Comment.nvim",
    }

    --    use {
    --      "tpope/vim-eunuch",
    --    }

    use {
      "lewis6991/impatient.nvim",
    }

    use {
      "tpope/vim-surround",
      keys = {
        { "n", "cs" },
        { "n", "ds" },
        { "x", "S" },
        { "n", "ys" },
      },
    }

    use {
      "tpope/vim-repeat",
    }

    use {
      "akinsho/toggleterm.nvim",
      tag = "*",
      config = function()
        require "rmagatti.toggleterm"
      end,
    }

    use {
      "mbbill/undotree",
      config = function()
        vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
      end,
      keys = "<leader>u",
    }

    -- Grepping
    use {
      "jremmen/vim-ripgrep",
      cmd = { "Rg" },
    }

    use {
      "mhinz/vim-grepper",
      config = function()
        vim.cmd [[
           nmap gs <Plug>(GrepperOperator)
           xmap gs <Plug>(GrepperOperator)
         ]]
      end,
      cmd = { "Grepper", "<Plug>(GrepperOperator)" },
      keys = {
        { "n", "gs" },
        { "x", "gs" },
      },
    }

    use {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require "rmagatti.nvim-web-devicons"
      end,
    }

    use {
      "vim-test/vim-test",
      config = function()
        require("rmagatti.vim-test").setup()
      end,
      keys = {
        { "n", "<leader>tf" },
        { "n", "<leader>tt" },
        { "n", "<leader>ts" },
        { "n", "<leader>tl" },
        { "n", "<leader>tv" },
        { "n", "<leader>wtf" },
        { "n", "<leader>wtt" },
        { "n", "<leader>wts" },
        { "n", "<leader>wtl" },
        { "n", "<leader>wtv" },
        { "n", "<leader>tdt" },
        { "n", "<leader>tdf" },
        { "n", "<leader>tds" },
        { "n", "<leader>tdl" },
        { "n", "<leader>tdv" },
      },
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require "rmagatti.nvim-autopairs"
      end,
      event = "InsertEnter",
    }

    use {
      "justinmk/vim-dirvish",
      config = function()
        vim.cmd [[
             command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish
             command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %
             nnoremap <leader>fs :VLeftDirvish<CR>
             nnoremap <leader>ff :VLeftDirvishFile<CR>
           ]]
      end,
    }

    use {
      "roginfarrer/vim-dirvish-dovish",
      branch = "main",
      requires = { "justinmk/vim-dirvish" },
      config = function()
        vim.cmd [[
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
      end,
    }

    use {
      "kristijanhusak/vim-dirvish-git",
      requires = { "justinmk/vim-dirvish" },
    }

    use {
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()
      end,
      module = { "leap" },
      keys = {
        { "n", "s" },
        { "n", "S" },
        { "n", "f" },
        { "n", "F" },
      },
    }

    -- -- TODO: testing out Neorg
    -- use {
    --   "vimwiki/vimwiki",
    --   branch = "dev",
    --   setup = function()
    --     -- let gwiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}
    --     vim.cmd "let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes':{'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}}]"
    --     vim.cmd [[
    --        let g:vimwiki_listsyms = '✗○◐●✓'
    --      ]]
    --   end,
    --   keys = {
    --     { "n", "<leader>ww" },
    --     { "n", "<leader>wi" },
    --     { "n", "<leader>w<leader>w" },
    --     { "n", "<leader>ws" },
    --   },
    --   ft = { "vimwiki", "markdown" },
    -- }

    use {
      "tommcdo/vim-exchange",
      keys = {
        { "n", "cx" },
        { "x", "X" },
      },
    }

    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
      config = function()
        require "rmagatti.firenvim"
      end,
    }

    use {
      "mg979/vim-visual-multi",
      branch = "master",
      keys = "<C-n>",
      config = function()
        vim.cmd [[let g:VM_custom_motions  = {'h': 'j', 'j': 'k', 'k':'l', 'l':';'}]]
      end,
    }

    use {
      "neovim/nvim-lspconfig",
      config = function()
        require "rmagatti.lsp"
      end,
    }

    -- LSP
    use "williamboman/mason.nvim"

    use "williamboman/mason-lspconfig.nvim"

    use {
      "j-hui/fidget.nvim",
      config = function()
        require "rmagatti.fidget"
      end,
    }

    use {
      "ray-x/lsp_signature.nvim",
      module = { "lsp_signature" },
    }

    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require "rmagatti.nvim-cmp"
      end,
    }

    use {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      tag = "v1.*",
      -- install jsregexp (optional!:).
      run = "make install_jsregexp",
      config = function()
        require "rmagatti.luasnip"
      end,
    }

    use "rafamadriz/friendly-snippets"

    use { "saadparwaiz1/cmp_luasnip" }

    -- TODO: testing out luasnip, remove if test succeeds
    -- use { "hrsh7th/cmp-vsnip", after = "nvim-cmp" }
    -- -- -- Snippets
    -- use {
    --   "hrsh7th/vim-vsnip",
    -- }

    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    -- TODO: is this necessary now that folke/neodev.nvim is installed?
    --  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
    use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
    use { "lukas-reineke/cmp-rg", after = "nvim-cmp" }

    use {
      "David-Kunz/cmp-npm",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("cmp-npm").setup {}
      end,
      after = "nvim-cmp",
    }

    use {
      "onsails/lspkind-nvim",
      module = "lspkind",
    }

    -- Lua plugin dev
    use {
      "folke/neodev.nvim",
    }

    -- -- Telescope
    use { "nvim-lua/plenary.nvim" }
    use {
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
      config = function()
        require "rmagatti.telescope"
      end,
      -- cmd = "Telescope",
      -- keys = {
      --   { "n", "<C-p>" },
      --   { "n", "<leader>ps" },
      --   { "n", "<leader>pg" },
      --   { "n", "<leader>pl" },
      --   { "n", "<leader>b" },
      --   { "n", "<M-CR>" },
      -- },
      -- module = { "telescope" },
    }

    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      requires = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope").load_extension "fzf"
      end,
      after = "telescope.nvim",
    }

    ---- Git
    use {
      "tpope/vim-fugitive",
      config = function()
        require("rmagatti.fugitive").setup()
      end,
    }

    use {
      "tpope/vim-rhubarb",
      after = "vim-fugitive",
    }

    use {
      "TimUntersberger/neogit",
      opt = true,
      cmd = { "Neogit" },
      keys = {
        { "n", "<leader>gg" },
      },
      config = function()
        require("neogit").setup {
          integrations = {
            diffview = true,
          },
        }
        vim.cmd [[nnoremap <leader>gg <cmd>Neogit<CR>]]
      end,
    }

    use {
      "sindrets/diffview.nvim",
      config = function()
        require "rmagatti.diffview"
      end,
      cmd = { "DiffviewOpen" },
      keys = "<leader>ddo",
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

    -- use {
    --   "ThePrimeagen/refactoring.nvim",
    --   requires = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    --   config = function()
    --     require "rmagatti.refactoring"
    --     vim.keymap.set("v", "<leader>re", [[<cmd>call v:lua.list_refactors()<CR>]], { silent = true, expr = true })
    --   end,
    --   keys = {
    --     { "v", "<leader>re" },
    --   },
    -- }

    -- Themes
    -- use { 'gruvbox-community/gruvbox' }

    use {
      "folke/tokyonight.nvim",
      config = function()
        require "rmagatti.tokyonight"
      end,
    }

    -- Tree-sitter
    use {
      "nvim-treesitter/nvim-treesitter", -- TODO: lazy load me! (maybe)
      run = ":TSUpdate",
      config = function()
        require "rmagatti.treesitter"
      end,
    }

    use {
      "nvim-treesitter/nvim-treesitter-context",
      requires = "nvim-treesitter/nvim-treesitter-context",
    }

    use {
      "nvim-treesitter/playground",
      requires = { "nvim-treesitter/nvim-treesitter" },
      cmd = "TSPlaygroundToggle",
    }

    -- Rainbow parentheses
    use {
      "p00f/nvim-ts-rainbow",
      event = "BufReadPost",
    }

    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = { "BufReadPost" },
    }

    use {
      "RRethy/nvim-treesitter-textsubjects",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = { "BufReadPost" },
    }

    -- -- GitHub
    --   use  {
    --     'pwntester/octo.nvim',
    --     config = function()
    --       require"octo".setup()
    --     end,
    --     cmd = {'Octo'}
    --   }

    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require "rmagatti.gitsigns"
      end,
      event = "BufRead",
    }

    -- Fzf
    use {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end,
      event = { "BufReadPost" },
    }

    use {
      "junegunn/fzf.vim",
      requires = "junegunn/fzf",
      after = { "nvim-bqf" },
    }

    -- Lualine
    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require "rmagatti.lualine"
      end,
    }

    -- Terraform
    use {
      "hashivim/vim-terraform",
      disable = false,
      ft = { "terraform" },
    }

    -- Text objects
    use {
      "wellle/targets.vim",
      event = { "BufReadPost" },
    }

    -- Symbols
    use {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup {
          highlight_hovered_item = true,
          show_guides = true,
        }
      end,
      cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    }

    -- Typescript utils
    use {
      "jose-elias-alvarez/null-ls.nvim",
    }

    use {
      "jose-elias-alvarez/typescript.nvim",
      requires = { "neovim/nvim-lspconfig", "jose-elias-alvarez/null-ls.nvim" },
    }

    use {
      "heavenshell/vim-jsdoc",
      ft = { "javascript", "javascript.jsx", "typescript" },
      cmd = "JsDoc",
      run = "make install",
    }

    -- Quickfix enhancements
    use {
      "kevinhwang91/nvim-bqf",
      requires = { { "junegunn/fzf", opt = true }, { "junegunn/fzf.vim", opt = true } },
      ft = { "qf" },
      config = function()
        require("bqf").setup {
          auto_enable = true,
        }
      end,
    }

    -- Aligning
    use {
      "junegunn/vim-easy-align",
      config = function()
        require "rmagatti.easyalign"
      end,
      cmd = { "EasyAlign" },
    }

    -- DAP
    use {
      "mfussenegger/nvim-dap",
      config = function()
        require("telescope").load_extension "dap"
        require "rmagatti.dap"
      end,
      keys = { { "n", "<leader>db" }, { "n", "<leader>dB" } },
    }
    use {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
    }
    use {
      "nvim-telescope/telescope-dap.nvim",
      requires = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope").load_extension "dap"
      end,
      after = "nvim-dap",
      module = "telescope._extensions.dap",
    }

    use {
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require "rmagatti.dap.dap-ui"
      end,
      after = "nvim-dap",
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      config = function()
        require "rmagatti.which-key"
      end,
    }

    -- Indent Blankline
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = { "InsertEnter" },
      setup = function()
        vim.g.indent_blankline_buftype_exclude = { "terminal" }
        vim.g.indent_blankline_filetype_exclude = { "toggleterm" }
      end,
    }

    -- Bufferize commands
    use {
      "AndrewRadev/bufferize.vim",
      cmd = { "Bufferize" },
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
          },
        }
        vim.cmd [[
        nnoremap <leader>zz :lua require("zen-mode").toggle({ window = { width = .40 }})<CR>
      ]]
      end,
      keys = "<leader>zz",
    }

    -- Profiling
    use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 10]] }

    use {
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = function()
        require("neoclip").setup {
          enable_persistant_history = true,
        }
        vim.cmd [[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
      end,
      keys = {
        { "n", "<leader>y" },
      },
    }

    -- Local
    use {
      "~/Projects/auto-session",
      config = function()
        require "rmagatti.auto-session"
      end,
    }

    use {
      "rmagatti/alternate-toggler",
      config = function()
        require("alternate-toggler").setup {
          alternates = {
            ["=="] = "!=",
          },
        }
        vim.keymap.set(
          "n",
          "<leader><space>", -- <space><space>
          require("alternate-toggler").toggleAlternate
        )
      end,
      event = { "BufReadPost" }, -- lazy load after reading a buffer
    }

    use {
      "rmagatti/goto-preview",
      config = function()
        require("rmagatti.goto-preview").setup()
      end,
      keys = {
        { "n", "gpd" },
        { "n", "gpi" },
        { "n", "gpr" },
        { "n", "gP" },
        { "n", "L" },
      },
    }

    -- use {
    --   "rmagatti/session-lens",
    --   requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    --   config = function()
    --     require "rmagatti.session-lens"
    --     require("telescope").load_extension "session-lens"
    --   end,
    --   keys = "<C-s>",
    -- }

    -- use {
    --   "rmagatti/telescope-ui-select.nvim",
    --   requires = { "nvim-telescope/telescope.nvim" },
    --   after = "telescope.nvim",
    --   config = function()
    --     require("telescope").load_extension "ui-select"
    --   end,
    -- }
    --
    use {
      "rmagatti/igs.nvim",
      event = { "BufReadPost" },
      config = function()
        require "rmagatti.igs"
      end,
    }

    -- use {
    --   "github/copilot.vim",
    --   event = { "InsertEnter" },
    --   config = function()
    --     require("rmagatti.copilot").setup()
    --   end,
    -- }

    use {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("rmagatti.copilot").setup()
      end,
    }

    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function()
        require("rmagatti.copilot-cmp").setup()
      end,
    }

    use {
      "eandrju/cellular-automaton.nvim",
      config = function()
        vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
      end,
      keys = {
        { "n", "<leader>fml" },
      },
    }

    use {
      "sourcegraph/sg.nvim",
      config = require("rmagatti.sg").setup,
      run = "cargo build --workspace",
      requires = { "nvim-lua/plenary.nvim" },
    }

    use "wakatime/vim-wakatime"

    use {
      "stevearc/dressing.nvim",
      config = function()
        require("rmagatti.dressing").setup()
      end,
    }

    use {
      "nvim-neorg/neorg",
      config = function()
        require("rmagatti.neorg").setup()
      end,
      run = ":Neorg sync-parsers",
      requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    }

    use {
      "~/Projects/gx-extended.nvim",
      config = function()
        require("rmagatti.gx-extended").setup()
      end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = config,
}
