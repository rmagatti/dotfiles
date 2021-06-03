local M = {}

local function tablefind(tab,el)
  for index, value in pairs(tab) do
    if value == el then
      return index
    end
  end
end

-- Use floating window
local windows = {}
local open_floating_win = function(target, position)
  local buffer = vim.api.nvim_create_buf(false, false)
  local bufpos = { vim.fn.line(".")-1, vim.fn.col(".") } -- FOR relative='win'
  -- local bufpos = {-1,-4}

  local curr_window = vim.api.nvim_get_current_win()
  local zindex = vim.tbl_isempty(windows) and 1 or #windows+1
  print("zindex", zindex)

  local new_window = vim.api.nvim_open_win(buffer, true, {
    relative='win',
    width=120,
    height=15,
    border={"↖", "─" ,"┐", "│", "┘", "─", "└", "│"},
    bufpos=bufpos,
    zindex=zindex,
    win=vim.api.nvim_get_current_win()
  })

  -- vim.api.nvim_win_set_option(new_window, "winblend", 15)
  vim.api.nvim_buf_set_option(buffer, 'bufhidden', 'wipe') -- necessary?

  table.insert(windows, new_window) -- TODO: remove from windows when window is closed

  print(vim.inspect({
    windows = windows,
    curr_window = curr_window,
    new_window = new_window,
    bufpos = bufpos,
    get_config = vim.api.nvim_win_get_config(new_window),
    get_current_line = vim.api.nvim_get_current_line()
  }))

  vim.cmd("e "..target)
  vim.cmd[[
    augroup close_float
      au!
      au WinClosed * lua require('rmagatti.floating').remove_curr_win()
    augroup end
  ]]

  vim.api.nvim_win_set_cursor(new_window, position)
end

local handler = function(_, _, result)
  if not result then return end

  local data = result[1]

  local target = nil
  local cursor_position = {}

  -- TODO:  apparently `data` is different depending on the language server :(
  -- Figure out a way for the user to pass this in
  if vim.bo.filetype == 'lua' then
    target = data.targetUri
    cursor_position = { data.targetRange.start.line + 1, data.targetRange.start.character }
  elseif vim.bo.filetype == 'typescript' then
    target = data.uri
    cursor_position = { data.range.start.line + 1, data.range.start.character }
  end

  open_floating_win(target, cursor_position)
end

local lsp_request = function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, handler)
end

local close_all_win = function()
  for index = #windows, 1, -1 do
    local window = windows[index]
    pcall(vim.api.nvim_win_close, window, true)
  end
end

M.remove_curr_win = function()
  local index = tablefind(windows, vim.api.nvim_get_current_win())
  if index then
    table.remove(windows, index)
  end
end

-- Mapping
local vimp = require('vimp')
vimp.unmap_all()
vimp.nnoremap('gp', lsp_request)
vimp.nnoremap('gP', close_all_win)

vimp.nnoremap('<left>', '<C-w><')
vimp.nnoremap('<right>', '<C-w>>')
vimp.nnoremap('<up>', '<C-w>-')
vimp.nnoremap('<down>', '<C-w>+')

return M



