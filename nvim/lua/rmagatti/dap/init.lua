local dap = require('dap')

-- Virtual text
vim.g.dap_virtual_text = true
-- request variable values for all frames (experimental)
-- vim.g.dap_virtual_text = 'all frames'

vim.cmd([[
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dk :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>d; :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dj :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
]])

-- Configs
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Projects/vscode-node-debug2/out/src/nodeDebug.js'},
}

-- dap.configurations.javascript = {
--   {
--     type = 'node2',
--     request = 'launch',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--   },
-- }

dap.configurations.typescript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

vim.fn.sign_define('DapBreakpoint', {text='🛑'})
vim.fn.sign_define('DapStopped', {text='🟢'})

-- Custom behaviour
local M = {}

M.attach_typescript = function()
  dap.run({
    type='node2',
    request='attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.ts'}
  })
end

M.debug_mocha = function(cmd)
  local test_cmd = './node_modules/ts-mocha/bin/ts-mocha'
  local args = cmd and {test_cmd, '--inspect-brk', '--no-parallel', (cmd:gsub('yarn test ', ''))} or {test_cmd, '--inspect-brk'}
  print(vim.inspect(table.concat(args, ' ')))

  dap.run({
    type='node2',
    request='launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = args,
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229
  })
end

M.debug = function(runner, cmd)
  if runner:find('javascript#mocha') then M.debug_mocha(cmd) end
  if runner:find('javascript#jest') then M.debug_jest(cmd) end
end

-- TODO: setup jest debugging
M.debug_jest = function(cmd)
  local test_cmd = './node_modules/jest/bin/jest.js'
  local args = cmd and {'npx node', '--inspect-brk', test_cmd, '--runInBand', (cmd:gsub('yarn test ', ''))} or {test_cmd, '--inspect-brk'}
  print(vim.inspect(table.concat(args, ' ')))

  dap.run({
    type='node2',
    request='launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = args,
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229
  })
end

-- Hover mapping
vim.cmd[[nnoremap <leader>dh <cmd>lua require('dap.ui.widgets').hover()<CR>]]

-- Disabled, use nvim-dap widgets instead
-- require('rmagatti.dap.dap-ui')

return M
