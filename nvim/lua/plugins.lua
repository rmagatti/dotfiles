local packer = require "packer"
local config = {
  compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  -- profile = {
  --   enable = true,
  --   threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  -- }
}

return packer.startup {
  function(use)
    use {
      "wbthomason/packer.nvim",
      -- commit = '8bee5e4ce13691fcb040eced2a219e637b7ef1a1',
    }

    use {
      "tpope/vim-commentary",
      keys = {
        { "n", "gc" },
      },
    }

    use {
      "tpope/vim-eunuch",
    }

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
      tag = "v2.*",
      config = function()
        require "rmagatti.toggleterm"
      end,
    }

    ----==== Lazy loaded

    use {
      "dbeniamine/cheat.sh-vim",
      keys = {
        { "n", "<leader>KB" },
        { "n", "<leader>KK" },
        { "n", "<leader>KP" },
      },
      cmd = { "Cheat", "CheatPaste" },
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

    -- use {
    --   "kyazdani42/nvim-web-devicons",
    --   config = function()
    --     require "rmagatti.nvim-web-devicons"
    --   end,
    -- }

    use {
      "vim-test/vim-test",
      config = function()
        vim.cmd [[
      let g:test#javascript#mocha#file_pattern = '\v(tests?/.*|(test))\.(js|jsx|coffee|ts)$'
      let test#javascript#mocha#executable = 'npm run test'
      let test#javascript#jest#executable = 'npm run test'

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
        { "n", "<leader>tf" },
        { "n", "<leader>tt" },
        { "n", "<leader>ts" },
        { "n", "<leader>tf" },
        { "n", "<leader>tt" },
        { "n", "<leader>tf" },
        { "n", "<leader>ts" },
        { "n", "<leader>tl" },
        { "n", "<leader>tv" },
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
      opt = true,
      requires = { "justinmk/vim-dirvish" },
    }

    use {
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").setup {}
      end,
      module = { "lightspeed" },
      keys = {
        { "n", "s" },
        { "n", "S" },
        { "n", "f" },
        { "n", "F" },
      },
    }

    use {
      "vimwiki/vimwiki",
      branch = "dev",
      setup = function()
        -- let gwiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}
        vim.cmd "let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes':{'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}}]"
        vim.cmd [[
        let g:vimwiki_listsyms = '✗○◐●✓'
      ]]
      end,
      keys = {
        { "n", "<leader>ww" },
        { "n", "<leader>wi" },
        { "n", "<leader>w<leader>w" },
        { "n", "<leader>ws" },
      },
      ft = { "vimwiki", "markdown" },
    }

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

    -- TODO: do I really use this?
    --use {
    -- 'michaeljsmith/vim-indent-object',
    -- event = 'BufReadPost'
    --}

    use {
      "mg979/vim-visual-multi",
      branch = "master",
      keys = "<C-n>",
      config = function()
        vim.cmd [[let g:VM_custom_motions  = {'h': 'j', 'j': 'k', 'k':'l', 'l':';'}]]
      end,
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
    }

    use {
      "williamboman/nvim-lsp-installer",
      config = function()
        require "rmagatti.lsp"
      end,
    }

    use {
      "ray-x/lsp_signature.nvim",
      module = { "lsp_signature" },
    }

    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require "rmagatti.nvim-cmp"
      end,
    }

    use { "hrsh7th/cmp-vsnip", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
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
      module = "neodev",
      ft = "lua",
    }

    use {
      "svermeulen/vimpeccable",
      module = "vimp",
    }

    -- -- Snippets
    use {
      "hrsh7th/vim-vsnip",
      event = { "BufReadPre" },
    }
    -- use {
    --   'hrsh7th/vim-vsnip-integ',
    --   event = {'BufReadPre'}
    -- }
    use {
      "rafamadriz/friendly-snippets",
      event = { "BufReadPre" },
    }

    -- -- Telescope
    -- popup.nvim is somewhat a legacy dependency, plenary includes popup nowadays
    -- use { "nvim-lua/popup.nvim" }
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

    -- use({
    --   "~/Projects/telescope-lsp-handlers.nvim",
    --   requires = { "telescope.nvim" },
    --   config = function()
    --     require("telescope").load_extension("lsp_handlers")
    --   end,
    --   after = "telescope.nvim",
    -- })

    -- use {
    --   "nvim-telescope/telescope-packer.nvim",
    --   config = function()
    --     require("telescope").load_extension "packer"
    --     vim.cmd [[nnoremap <leader>pl :lua require('telescope').extensions.packer.plugins()<CR>]]
    --   end,
    --   after = "telescope.nvim",
    -- }

    -- Diagnostics
    use {
      "folke/lsp-trouble.nvim",
      config = function()
        require("trouble").setup()
        vim.cmd [[nnoremap <leader>xx <cmd>Trouble<CR>]]
      end,
      keys = "<leader>xx",
      cmd = { "Trouble" },
    }
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end,
      cmd = { "TodoQuickFix", "TodoTrouble", "TodoTelescope" },
    }

    use {
      "kosayoda/nvim-lightbulb",
      config = function()
        require "rmagatti.nvim-lightbulb"
      end,
      event = "BufReadPost",
    }

    ---- Git
    use {
      "tpope/vim-fugitive",
      cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gvdiffsplit" },
      config = function()
        vim.cmd [[
        nnoremap <silent> <leader>gb :<C-u>Git blame<CR>
        nnoremap <silent> gb :<C-u>Git blame<CR>
        nnoremap <leader>gd :Gvdiffsplit!<CR>
        nnoremap gj :diffget //2<CR>
        nnoremap g; :diffget //3<CR>
        ]]
      end,
      keys = {
        { "n", "gb" },
        { "n", "<leader>gd" },
        { "n", "<leader>gb" },
        -- { "n", "<leader>hp" },
        -- { "n", "<leader>hs" },
        -- { "n", "<leader>hu" },
        -- { "n", "<leader>hr" },
        -- { "n", "<leader>hR" },
        -- { "n", "<leader>hp" },
        -- { "n", "<leader>hb" },
      },
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

    use {
      "ThePrimeagen/refactoring.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = function()
        require "rmagatti.refactoring"
        vim.keymap.set("v", "<leader>re", [[<cmd>call v:lua.list_refactors()<CR>]], { silent = true, expr = true })
      end,
      keys = {
        { "v", "<leader>re" },
      },
    }

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

    use {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "BufReadPost",
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

    -- TODO: table index is null issue when this is enabled
    -- use {
    --   'nvim-lua/lsp-status.nvim',
    -- }

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
        require "rmagatti.session-lens"
      end,
    }

    use {
      "~/Projects/alternate-toggler",
      config = function()
        vim.keymap.set(
          "n",
          "<leader><space>",
          "<cmd>lua require('alternate-toggler').toggleAlternate(vim.fn.expand('<cword>'))<CR>"
        )
        vim.cmd [[ let g:at_custom_alternates = {'===': '!=='} ]]
      end,
      event = { "BufReadPost" },
    }

    use {
      "~/Projects/goto-preview",
      config = function()
        require "rmagatti.goto-preview"
      end,
      keys = {
        { "n", "gpd" },
        { "n", "gpi" },
        { "n", "gpr" },
        { "n", "gP" },
      },
    }

    -- use {
    --   "~/Projects/session-lens",
    --   requires = { "~/Projects/auto-session", "nvim-telescope/telescope.nvim" },
    --   config = function()
    --     require "rmagatti.session-lens"
    --     require("telescope").load_extension "session-lens"
    --   end,
    --   keys = "<C-s>",
    -- }

    use {
      "~/Projects/telescope-ui-select.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension "ui-select"
      end,
    }

    use {
      "~/Projects/igs.nvim",
      config = function()
        require "rmagatti.igs"
      end,
    }

    -- use {
    --   "github/copilot.vim",
    --   event = { "InsertEnter" },
    --   config = function()
    --     vim.g.copilot_filetypes = {
    --       ["*"] = false,
    --       ["c"] = true,
    --       ["cpp"] = true,
    --       ["c++"] = true,
    --       ["c#"] = true,
    --       ["csharp"] = true,
    --       ["cs"] = true,
    --       ["css"] = true,
    --       ["html"] = true,
    --       ["js"] = true,
    --       ["javascript"] = true,
    --       ["typescript"] = true,
    --       ["json"] = true,
    --       ["lua"] = true,
    --       ["php"] = true,
    --       ["py"] = true,
    --       ["python"] = true,
    --       ["ruby"] = true,
    --       ["rust"] = true,
    --       ["sh"] = true,
    --       ["vim"] = true,
    --       ["yaml"] = true,
    --     }
    --   end,
    -- }

    --- ===== copilot =====
    -- use {
    --   "zbirenbaum/copilot.lua",
    --   event = "InsertEnter",
    --   config = function()
    --     vim.schedule(function()
    --       require("copilot").setup()
    --     end)
    --   end,
    --   enabled = false,
    -- }

    -- use {
    --   "zbirenbaum/copilot-cmp",
    --   module = "copilot_cmp",
    --   enabled = false,
    -- }
    --- ===== copilot =====

    -- use {
    --   "mattn/emmet-vim",
    -- }

    -- use {
    --   "michaelb/sniprun",
    --   run = "bash ./install.sh",
    --   cmd = { "SnipRun" },
    --   module = "sniprun",
    -- }
  end,
  config = config,
}
