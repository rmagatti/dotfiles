local mapping_func = function(wincmd_direction, bufr)
  local function close()
    vim.cmd("wincmd " .. wincmd_direction)
    require("goto-preview").close_all_win { skip_curr_window = true }
  end

  vim.keymap.set("n", "<C-w>" .. wincmd_direction, close, {
    noremap = true,
    silent = true,
    buffer = bufr,
  })
end

require("goto-preview").setup {
  default_mappings = true,
  resizing_mappings = true,
  winblend = 10,
  debug = false,
  post_open_hook = function(bufr)
    mapping_func("H", bufr)
    mapping_func("J", bufr)
    mapping_func("K", bufr)
    mapping_func("L", bufr)
  end,
}

-- Mapping to cycle between windows
vim.keymap.set("n", "<C-h>", "<C-w>w")

-- "Peek" mapping
vim.keymap.set(
  "n",
  "L", -- for "look"
  function()
    require("goto-preview").goto_preview_definition { focus_on_open = false, dismiss_on_move = true }
  end,
  { noremap = true }
)
