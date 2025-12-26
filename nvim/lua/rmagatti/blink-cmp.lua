local M = {}

M.setup = function()
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  local opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      preset = 'default',
      ['<C-;>'] = { 'select_and_accept' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      menu = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      },
      documentation = {
        window = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
        },
      },
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', "codecompanion", "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        }
      }
      -- optionally disable cmdline completions
      -- cmdline = {},
    },

    -- experimental signature help support
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
      },
    }
  }

  require("blink.cmp").setup(opts)
end

return M
