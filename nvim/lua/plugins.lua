return {
  -- Tim Pope plugins - minimal impact
  { "tpope/vim-eunuch", event = "VeryLazy" },
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
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "gcs" },
      { "gcb" },
      { "gcc" },
    },
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
    event = "VeryLazy",
  },

  -- Terminal and file management
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
    cmd = "UndotreeShow",
    keys = "<leader>u",
    config = function()
      vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
    end,
  },
  {
    "jremmen/vim-ripgrep",
    cmd = { "Rg" },
  },
  {
    "mhinz/vim-grepper",
    event = "VeryLazy",
    init = function()
      vim.cmd [[
          nmap gs <plug>(GrepperOperator)
          xmap gs <plug>(GrepperOperator)
        ]]
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require "rmagatti.nvim-web-devicons"
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "rmagatti.nvim-autopairs"
    end,
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = "-",
    config = function()
      require("rmagatti.oil").setup()
    end,
  },
  -- Navigation and motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "tommcdo/vim-exchange",
    keys = {
      { "cx" },
      { "X", mode = "x" },
    },
  },
  {
    "glacambre/firenvim",
    cond = function()
      return vim.g.started_by_firenvim ~= nil
    end,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require "rmagatti.firenvim"
    end,
  },
  -- {
  --   "mg979/vim-visual-multi",
  --   branch = "master",
  --   keys = "<C-n>",
  --   config = function()
  --     vim.cmd [[let g:VM_custom_motions  = {'h': 'j', 'j': 'k', 'k':'l', 'l':';'}]]
  --   end,
  -- },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- TODO: Fix these mappings or goto-preview's mappings for growing the window which area also using directional keys
      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
      set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
      set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
      set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
  },

  -- LSP and completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "j-hui/fidget.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "BufReadPost",
    config = function()
      require "rmagatti.lsp"
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    event = { "BufReadPost", "BufNewFile" },
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
    event = "LspAttach",
  },
  {
    "Saghen/blink.cmp",
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v1.*',
    event = "InsertEnter",
    config = function()
      require("rmagatti.blink-cmp").setup()
    end,
  },
  {
    "onsails/lspkind-nvim",
    event = "InsertEnter",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Core utilities
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff" },
      { "<leader>fg" },
      { "<leader>fb" },
      { "<leader>fh" },
      { "<leader>ps" },
    },
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function()
          require("telescope").load_extension("fzf")
        end,
      }
    },
    config = function()
      require "rmagatti.telescope"
    end
  },
  -- Git
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
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
    cmd = { "GBrowse" },
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
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

  -- UI and themes
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Keep this for immediate theme loading
    priority = 1000,
    config = function()
      require "rmagatti.kanagawa"
    end,
  },

  -- Treesitter
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
    dependencies = "nvim-treesitter/nvim-treesitter",
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
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", optional = true } },
    config = function()
      require "rmagatti.lualine"
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
  },
  {
    "wellle/targets.vim",
    event = { "BufReadPost" },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    config = function()
      require "rmagatti.bqf"
    end,
  },
  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    cmd = {
      "DapToggleBreakpoint",
      "DapContinue",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate"
    },
    keys = {
      { "<leader>db" },
      { "<leader>dc" },
      { "<leader>dB" },
    },
    config = function()
      require "rmagatti.dap"
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
    event = "BufReadPost",
    cond = function()
      return package.loaded["dap"] ~= nil
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    cmd = { "Telescope dap" },
    keys = { "<leader>df" },
    config = function()
      require("telescope").load_extension "dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    cmd = { "DapUIToggle", "DapUIOpen" },
    keys = { "<leader>du" },
    config = function()
      require "rmagatti.dap.dap-ui"
    end,
  },
  -- Utilities
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
    dependencies = { "tami5/sqlite.lua" },
    event = "BufReadPost",
    keys = { "<leader>y" },
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
  },
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    config = function()
      require "rmagatti.auto-session"
    end,
    dev = true
  },
  {
    "rmagatti/alternate-toggler",
    keys = "<leader><space>",
    config = function()
      require("alternate-toggler").setup {
        alternates = {
          ["=="] = "!=",
        },
      }
      vim.keymap.set(
        "n",
        "<leader><space>",
        require("alternate-toggler").toggleAlternate
      )
    end,
  },
  {
    "rmagatti/goto-preview",
    dev = true,
    dependencies = { "rmagatti/logger.nvim" },
    event = { "VeryLazy" },
    keys = {
      { "gpd" },
      { "gpi" },
      { "gpr" },
      { "gP" },
      { "L" },
      { "<leader>rn" },
    },
    config = function()
      require("rmagatti.goto-preview").setup()
    end,
  },
  {
    "rmagatti/igs.nvim",
    event = { "VeryLazy" },
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
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>fml" },
    },
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    end,
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy"
  },
  {
    "rmagatti/gx-extended.nvim",
    keys = { "gx" },
    config = function()
      require("rmagatti.gx-extended").setup()
    end,
    dev = true
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
  },
  -- Term color codes when looking at logs
  -- {
  --   "m00qek/baleia.nvim",
  --   config = function()
  --     require("baleia").setup {}
  --   end
  -- },
  {
    "olimorris/codecompanion.nvim",
    event = { "InsertEnter" },
    cmd = { "CodeCompanion" },
    keys = {
      { "<localleader>," },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("rmagatti.codecompanion").setup()
    end,
  },
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    config = function()
      require("rmagatti.snacks").setup()
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'codecompanion' },
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
    },
    cmd = { "Neotest" },
    config = function()
      require("rmagatti.neotest").setup()
    end,
    keys = {
      { "<leader>tt" },
      { "<leader>tf" },
      { "<leader>ts" },
      { "<leader>ta" },
    }
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require("rmagatti.nvim-lint").setup()
    end
  }
}
