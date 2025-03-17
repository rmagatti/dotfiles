local dap = require "dap"

-- Virtual text
vim.g.dap_virtual_text = true
-- request variable values for all frames (experimental)
-- vim.g.dap_virtual_text = 'all frames'

-- DAP keybindings
-- Movement
vim.keymap.set('n', '<leader>dc', require('dap').continue, { silent = true, desc = "Continue" })
vim.keymap.set('n', '<leader>dk', require('dap').step_over, { silent = true, desc = "Step over" })
vim.keymap.set('n', '<leader>d;', require('dap').step_into, { silent = true, desc = "Step into" })
vim.keymap.set('n', '<leader>dj', require('dap').step_out, { silent = true, desc = "Step out" })

-- Breakpoints
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { silent = true, desc = "Toggle breakpoint" })
vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { silent = true, desc = "Conditional breakpoint" })
vim.keymap.set('n', '<leader>dl',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
  { silent = true, desc = "Log point" })
vim.keymap.set('n', '<leader>dr', require('dap').repl.open, { silent = true, desc = "Open REPL" })
vim.keymap.set('n', '<leader>du', require('dapui').toggle, { silent = true, desc = "Toggle UI" })

-- vim.fn.sign_define("DapBreakpoint", { text = "🛑" })
-- vim.fn.sign_define("DapStopped", { text = "🟢" })

vim.fn.sign_define("DapBreakpoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapConditionalBreakpoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

-- Hover mapping
vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end)

-- Custom behaviour
local M = {}

return M
