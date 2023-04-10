vim.cmd [[
  let g:firenvim_config = {'globalSettings': {'alt': 'all', },'localSettings': {'.*': {'cmdline': 'neovim','content': 'text','priority': 0,'selector': 'textarea','takeover': 'never'}}}
  let fc = g:firenvim_config['localSettings']
  let fc['https?://docs.google.com/spreadsheets/'] = { 'takeover': 'never', 'priority': 1 }
  let fc['https?://meet.google.com/'] = { 'takeover': 'never', 'priority': 1 }
]]

vim.api.nvim_create_autocmd({ "UIEnter" }, {
  callback = function(event)
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
    if client ~= nil and client.name == "Firenvim" then
      vim.o.laststatus = 0
      vim.o.guifont = "JetBrains_Mono:h16"
    end
  end,
})
