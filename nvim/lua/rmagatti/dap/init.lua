local dap = require "dap"

-- Virtual text
vim.g.dap_virtual_text = true
-- request variable values for all frames (experimental)
-- vim.g.dap_virtual_text = 'all frames'

vim.cmd [[
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dk :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>d; :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dj :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>du :lua require'dapui'.toggle()<CR>
]]

-- Configs
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv "HOME" .. "/Projects/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
  {
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "🛑" })
vim.fn.sign_define("DapStopped", { text = "🟢" })

-- Custom behaviour
local M = {}

M.attach_typescript = function()
  dap.run {
    type = "node2",
    request = "attach",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**/*.ts" },
  }
end

M.debug_mocha = function(cmd)
  local test_cmd = "./node_modules/ts-mocha/bin/ts-mocha"
  local prefix_removed = (cmd:gsub("yarn test ", ""))
  local final_cmd = test_cmd .. " " .. prefix_removed

  print("==== cmd", final_cmd)

  local split_cmd = vim.split(prefix_removed, "--grep")
  local file_or_grep_split = split_cmd[2] and { vim.trim(split_cmd[1]), "--grep", vim.trim(split_cmd[2]) }
    or split_cmd[1]
  local args = cmd and { test_cmd, "--inspect-brk", "--no-parallel", file_or_grep_split }
    or { test_cmd, "--inspect-brk" }

  print("args", args)

  dap.run {
    type = "node2",
    request = "launch",
    cwd = vim.fn.getcwd(),
    runtimeArgs = args,
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**/*.js" },
    console = "integratedTerminal",
    port = 9229,
  }
end

M.debug = function(runner, cmd)
  if runner:find "javascript#mocha" then
    M.debug_mocha(cmd)
  end
  if runner:find "javascript#jest" then
    M.debug_jest(cmd)
  end
end

-- TODO: setup jest debugging
M.debug_jest = function(cmd)
  local test_cmd = "./node_modules/jest/bin/jest.js"
  local args = cmd and { "./node_modules/ts-node/dist/bin.js", "--inspect-brk", test_cmd, "--runInBand", (cmd:gsub("yarn test ", "")) }
    or { test_cmd, "--inspect-brk" }
  print(vim.inspect(table.concat(args, " ")))

  dap.run {
    type = "node2",
    request = "launch",
    cwd = vim.fn.getcwd(),
    runtimeArgs = args,
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**/*.js" },
    console = "integratedTerminal",
    port = 9229,
  }
end

-- Hover mapping
vim.cmd [[nnoremap <leader>dh <cmd>lua require('dap.ui.widgets').hover()<CR>]]

return M
