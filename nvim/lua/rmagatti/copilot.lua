local M = {}

M.setup = function()
  require("copilot").setup {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
        next = "<C-k>",
        prev = "<C-l>",
      },
    },
    copilot_node_command = "node",
    nes = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept_and_goto = "<tab>",
        accept = false,
        dismiss = "<esc>",
      },
    },
    panel = { enabled = false },
  }
end

return M
