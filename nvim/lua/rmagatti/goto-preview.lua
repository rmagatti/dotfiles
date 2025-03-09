local M = {}

M.setup = function()
  local mapping_fn = function(wincmd_direction, bufr)
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
      mapping_fn("H", bufr)
      mapping_fn("J", bufr)
      mapping_fn("K", bufr)
      mapping_fn("L", bufr)
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
end

return M
