local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.setup {
  check_ts = true
}

vim.g.completion_confirm_key = ""

_G.MUtils = {}


-- Complete on enter key
MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc(""))
    else
      vim.api.nvim_select_popupmenu_item(0, false, false,{})
      vim.fn["compe#confirm"]()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.check_break_line_char()
  end
end

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
  :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
  :with_pair(ts_conds.is_not_ts_node({'function'}))
})

vim.api.nvim_set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

