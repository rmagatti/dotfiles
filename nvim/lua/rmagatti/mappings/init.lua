require "rmagatti.mappings.neorg"

local function delete_hidden_buffers(options)
  local force = options and options.force or false
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if vim.fn.buflisted(buffer) and vim.fn.bufwinnr(buffer) == -1 then
      if not force then
        vim.api.nvim_command("bwipeout " .. buffer)
      else
        vim.api.nvim_command("bwipeout! " .. buffer)
      end
    end
  end
end

vim.keymap.set("n", "<leader>cab", delete_hidden_buffers)
vim.keymap.set("n", "<leader>cab!", function()
  delete_hidden_buffers { force = true }
end)

if vim.g.neovide then
  vim.keymap.set("n", "<D-p>", function()
    local success, _ = pcall(require("telescope.builtin").git_files)
    if not success then
      require("telescope.builtin").find_files()
      return
    end
  end
  , {})
end

local function close_fugitive_buffers()
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer)
    if string.find(buffer_name, "fugitive:") then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end

vim.keymap.set("n", "<localleader>cd", close_fugitive_buffers, { desc = "Close diff (fugitive) buffers" })

vim.keymap.set('n', '<localleader>qq',
  function()
    if vim.fn.empty(vim.fn.getwininfo()) == 1 then
      vim.cmd('copen')
    else
      local quickfix_open = false
      ---@diagnostic disable-next-line: param-type-mismatch
      for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] == 1 then
          quickfix_open = true
          vim.cmd('cclose')
        end
      end
      if not quickfix_open then
        vim.cmd('copen')
      end
    end
  end, { noremap = true, silent = true })

local function get_visual_selection()
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'v' or mode == 'V' or mode == 'CTRL-V' then
    local start_pos = vim.fn.getpos('v')
    local end_pos = vim.fn.getpos('.')
    -- Adjust for potential backward selection
    if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
      start_pos, end_pos = end_pos, start_pos
    end

    local start_line = start_pos[2]
    local start_col = start_pos[3]
    local end_line = end_pos[2]
    local end_col = end_pos[3]

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local selected_text = {}

    if start_line == end_line then
      table.insert(selected_text, string.sub(lines[1], start_col, end_col))
    else
      table.insert(selected_text, string.sub(lines[1], start_col))
      for i = 2, #lines - 1 do
        table.insert(selected_text, lines[i])
      end
      table.insert(selected_text, string.sub(lines[#lines], 1, end_col))
    end
    return table.concat(selected_text, "\n")
  end
  return ""
end

-- Keymap on visual mode for H to show the help for the selected text with :h <selected_text>
vim.keymap.set('x', 'H', function()
  local visual_selection = get_visual_selection()
  if visual_selection ~= "" then
    vim.cmd('h ' .. visual_selection)
  end
end, { noremap = true, silent = true, desc = "Help for selected text" })
