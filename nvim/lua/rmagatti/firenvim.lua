vim.cmd([[
  let g:firenvim_config = {'globalSettings': {'alt': 'all', },'localSettings': {'.*': {'cmdline': 'neovim','content': 'text','priority': 0,'selector': 'textarea','takeover': 'always'}}}
  let fc = g:firenvim_config['localSettings']
  let fc['https?://docs.google.com/spreadsheets/'] = { 'takeover': 'never', 'priority': 1 }
  let fc['https?://meet.google.com/'] = { 'takeover': 'never', 'priority': 1 }
]])
