local M = {}

M.setup = function ()
  require('neotest').setup {
    adapters = {
      require('rustaceanvim.neotest')
    },
  }
end

return M
