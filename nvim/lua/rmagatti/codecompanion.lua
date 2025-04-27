local M = {}

M.setup = function()
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "copilot",
        slash_commands = {
          buffer = {
            opts = {
              provider = "telescope"
            }
          },
          file = {
            opts = {
              provider = "telescope"
            }
          },
          help = {
            opts = {
              provider = "telescope"
            }
          },
          symbols = {
            opts = {
              provider = "telescope"
            }
          }
        }
      },
      inline = {
        adapter = "copilot",
      },
    },
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "gemini-2.5-pro"
            }
          }
        })
      end
    },
    opts = {
      log_level = "TRACE",
    }
  })

  vim.keymap.set({ "n", "v" }, "<D-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  vim.keymap.set({ "n", "v" }, "<localleader>,", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
  vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])
end

return M
