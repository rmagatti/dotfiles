-- CodeCompanion configuration
-- Documentation: https://codecompanion.olimorris.dev/configuration/adapters

local M = {}

M.setup = function()
  require("codecompanion").setup {
    -- Top-level options
    opts = {
      log_level = "TRACE",
    },

    -- Adapters configuration - new structure
    adapters = {
      http = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-5",
                -- default = "claude-sonnet-4"
                -- default = "gemini-2.5-pro"
              },
            },
          })
        end,
      },
    },

    -- Strategies configuration - simplified
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },

    -- Slash commands - new grouped structure
    slash_commands = {
      chat = {
        buffer = {
          description = "Insert current buffer with telescope provider",
          opts = {
            provider = "telescope",
          },
        },
        file = {
          description = "Insert file content with telescope provider",
          opts = {
            provider = "telescope",
          },
        },
        help = {
          description = "Get help with telescope provider",
          opts = {
            provider = "telescope",
          },
        },
        symbols = {
          description = "Insert symbols with telescope provider",
          opts = {
            provider = "telescope",
          },
        },
      },
    },
  }

  -- Keymaps
  vim.keymap.set({ "n", "v" }, "<D-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  vim.keymap.set({ "n", "v" }, "<localleader>,", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
  vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd [[cab cc CodeCompanion]]
end

return M
