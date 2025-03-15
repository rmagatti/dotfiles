return {
  { "tpope/vim-eunuch" },
  {
    "tpope/vim-commentary",
    keys = {
      { "gc" },
      { "gc", mode = "v" },
    }
  },
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("rmagatti.treesitter-context-commentstring").setup()
    end,
  },
  {
    "tpope/vim-surround",
    keys = {
      { "cs" },
      { "ds" },
      { "S", mode = "x" },
      { "ys" },
    },
  },
  {
    "tpope/vim-repeat",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "rmagatti.toggleterm"
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
    end,
    keys = "<leader>u",
  },
  {
    "jremmen/vim-ripgrep",
    cmd = { "Rg" },
  },
  {
    "mhinz/vim-grepper",
    lazy = false,
    init = function()
      vim.cmd [[
        nmap gs <plug>(GrepperOperator)
        xmap gs <plug>(GrepperOperator)
      ]]
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "rmagatti.nvim-web-devicons"
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require "rmagatti.nvim-autopairs"
    end,
    event = "InsertEnter",
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("rmagatti.oil").setup()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  -- {
  --   "ggandor/leap.nvim",
  --   config = function()
  --     require("leap").create_default_mappings()
  --     vim.keymap.set({ "n", "x", "o" }, "<localleader>s", '<Plug>(leap-from-window)')
  --   end,
  --   keys = {
  --     { "s" },
  --     { "S" },
  --     { "f" },
  --     { "F" },
  --     { "<localleader>s", mode = { "n", "x", "o" } }
  --   },
  -- },
  {
    "tommcdo/vim-exchange",
    keys = {
      { "cx" },
      { "X", mode = "x" },
    },
  },
  {
    "glacambre/firenvim",
    lazy = false,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require "rmagatti.firenvim"
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = "<C-n>",
    config = function()
      vim.cmd [[let g:VM_custom_motions  = {'h': 'j', 'j': 'k', 'k':'l', 'l':';'}]]
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "j-hui/fidget.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "cordx56/rustowl"
    },
    event = "BufReadPost",
    config = function()
      require "rmagatti.lsp"
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require "rmagatti.fidget"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "Saghen/blink.cmp",
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    config = function()
      require("rmagatti.blink-cmp").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v1.*",
    build = "make install_jsregexp",
    config = function()
      require "rmagatti.luasnip"
    end,
  },
  { "rafamadriz/friendly-snippets" },
  {
    "onsails/lspkind-nvim",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require "rmagatti.telescope"
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      require("rmagatti.fugitive").setup()
    end,
    keys = {
      { "<leader>gb" },
      { "<leader>gd" },
    }
  },
  {
    "tpope/vim-rhubarb",
    dependencies = "vim-fugitive",
  },
  {
    -- TODO: Try to get neogit diffs to be colored
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
    config = function()
      require("rmagatti.neogit")
    end,
    keys = {
      { "<leader>gg" },
    },
    cmd = { "Neogit" },
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require "rmagatti.diffview"
    end,
    cmd = { "DiffviewOpen" },
    keys = {
      { "<leader>dvo" },
      { "<leader>dvc" },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000,
    config = function()
      require "rmagatti.kanagawa"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "rmagatti.treesitter"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
    enabled = true,
    config = function()
      require('nvim-treesitter-textsubjects').configure({
        prev_selection = ',',
        keymaps = {
          ['.'] = 'textsubjects-smart',
          ["'"] = 'textsubjects-container-outer',
          ["i'"] = 'textsubjects-container-inner',
        },
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "rmagatti.gitsigns"
    end,
    event = "BufRead",
  },
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
    event = { "BufReadPost" },
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "kevinhwang91/nvim-bqf", "junegunn/fzf" },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", optional = true } },
    config = function()
      require "rmagatti.lualine"
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
  },
  {
    "wellle/targets.vim",
    event = { "BufReadPost" },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { { "junegunn/fzf", optional = true }, { "junegunn/fzf.vim", optional = true } },
    ft = { "qf" },
    config = function()
      require "rmagatti.bqf"
    end,
  },
  -- {
  --   "junegunn/vim-easy-align",
  --   config = function()
  --     require "rmagatti.easyalign"
  --   end,
  --   cmd = { "EasyAlign" },
  -- },
  -- DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
    config = function()
      require("telescope").load_extension "dap"
      require "rmagatti.dap"
    end,
    keys = { { "<leader>db" }, { "<leader>dB" } },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "rmagatti.dap.dap-ui"
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require "rmagatti.which-key"
    end,
  },
  {
    "AndrewRadev/bufferize.vim",
    cmd = { "Bufferize" },
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "tami5/sqlite.lua", },
    event = "BufReadPost",
    config = function()
      require("neoclip").setup {
        enable_persistent_history = true,
        keys = {
          telescope = {
            i = {
              paste = false --will restore telescope default <c-p> action to move to prev item
            }
          }
        }
      }
      vim.cmd [[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
    end,
    keys = {
      { "<leader>y" },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require "rmagatti.auto-session"
    end,
    dev = true
  },
  {
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
    event = { "BufReadPost" },
  },
  {
    "rmagatti/goto-preview",
    dev = true,
    dependencies = { "rmagatti/logger.nvim" },
    config = function()
      require("rmagatti.goto-preview").setup()
    end,
    keys = {
      { "gpd" },
      { "gpi" },
      { "gpr" },
      { "gP" },
      { "L" },
      -- This is the rename keymap. Since goto-preview is providing vim.ui.input functionality we need to lazy load goto-preview when the keymap is used.
      { "<leader>rn" },
    },
  },
  {
    "rmagatti/igs.nvim",
    event = { "BufReadPost" },
    dev = true,
    config = function()
      require "rmagatti.igs"
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    config = function()
      require("rmagatti.copilot").setup()
    end,
  },
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    end,
    keys = {
      { "<leader>fml" },
    },
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy"
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
    lazy = false
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("rmagatti.neorg").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    cmd = { "Neorg" },
    lazy = false,
    keys = {
      { "<leader>nn" }
    }
  },
  {
    "benlubas/neorg-interim-ls",
  },
  {
    "rmagatti/gx-extended.nvim",
    config = function()
      require("rmagatti.gx-extended").setup()
    end,
    keys = {
      { "gx" },
    },
    dev = true
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    ft = { 'rust' },
    lazy = false,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },

    },
    config = function()
      require("rmagatti.refactoring").setup()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/vault/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/vault/**.md",
      -- "VeryLazy"
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "Vault",
          path = vim.fn.expand "~" .. "/Documents/vault",
        },
      },

      daily_notes = {
        folder = "Daily Notes",
        template = "Templates/Daily Note Template.md"
      }
    },

  },
  {
    "m00qek/baleia.nvim",
    config = function()
      require("baleia").setup {}
    end
  },
  {
    "olimorris/codecompanion.nvim",
    event = { "InsertEnter" },
    config = function()
      require("rmagatti.codecompanion").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<localleader>," },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = true },
      dim = { enabled = true },
      notifier = { enabled = true },
      zen = { enabled = true }
      -- TODO: Add mappings for dimming and zen
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    ft = { 'markdown', 'codecompanion' },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapter plugins
      "marilari88/neotest-vitest",
      -- 'mrcjkb/rustaceanvim',
    },
    config = function()
      require("rmagatti.neotest").setup()
    end,
    keys = {
      { "<leader>tt" },
      { "<leader>tf" },
      { "<leader>ts" },
      { "<leader>ta" },
    }
  }
}
