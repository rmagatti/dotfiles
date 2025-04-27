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
