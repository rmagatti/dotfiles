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
    panel = { enabled = false },
  }
end

return M
