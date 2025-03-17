---@diagnostic disable: missing-fields
local M = {}

M.setup = function()
  require('neotest').setup {
    adapters = {
      require('rustaceanvim.neotest'),
      require("neotest-vitest") {
        -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
        filter_dir = function(name, _, _)
          return name ~= "node_modules"
        end,
      }
    },
  }

  local function map(mode, key, cmd, description)
    vim.keymap.set(mode, key, cmd,
      { noremap = true, silent = true, desc = description and description or 'Neotest: unknown mapping' })
  end

  local function debug_nearest()
    require("neotest").run.run({ strategy = "dap" })
  end

  local function debug_file()
    require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
  end

  local run_nearest = function()
    require('neotest').run.run()
  end

  local run_file = function()
    require('neotest').run.run(vim.fn.expand("%"))
  end

  map('n', '<leader>tt', run_nearest, 'Run nearest test')
  map('n', '<leader>tf', run_file, 'Run the current test file')

  map('n', '<leader>tdt', debug_nearest, 'Debug nearest test')
  map('n', '<leader>tdf', debug_file, 'Debug the current test file')

  map('n', '<leader>ts', require('neotest').summary.open, 'Summary of test results')
  map('n', '<leader>ta', require('neotest').run.attach, 'Attach to the nearest test, see :h neotest.run.attach()')
  map('n', '<leader>top', require('neotest').output_panel.open, 'Open the output panel')
  map('n', '<leader>tow', require('neotest').output.open, 'Open the output window')
  map('n', '<leader>tc', require('neotest').run.stop, 'Stop running tests')
end

return M
