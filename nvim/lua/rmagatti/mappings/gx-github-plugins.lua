local user_clipboard = nil
local user_register = nil
local user_register_mode = nil

local function snapshot_and_clean()
  user_clipboard = vim.o.clipboard
  user_register = vim.fn.getreg '"'
  user_register_mode = vim.fn.getregtype '"'

  vim.o.clipboard = nil
end

local function restore_snapshot()
  vim.fn.setreg('"', user_register, user_register_mode)
  vim.o.clipboard = user_clipboard
end

local function run_bypassing_clipboard(fn)
  snapshot_and_clean()
  local to_return = fn()
  restore_snapshot()

  return to_return
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "plugins.lua" },
  group = vim.api.nvim_create_augroup("gxplugins", {
    clear = false,
  }),
  callback = function()
    vim.keymap.set("n", "gx", function()
      run_bypassing_clipboard(function()
        vim.cmd [[normal! yi"]]
        local yanked_string = vim.fn.getreg '"'

        -- Not a great match, but it's good enough for now
        if not string.match(yanked_string, ".*/.*") then
          local line_string = vim.api.nvim_get_current_line()
          -- Not a great match, but it's good enough for now as well
          local match = line_string:match "(https?%S+)"

          -- print(vim.inspect {
          --   line_string = line_string,
          --   match = match,
          -- })

          if not match then
            print "No URL found on current line"
            return
          end

          vim.api.nvim_call_function("netrw#BrowseX", { match, 0 })

          return
        end

        local github_url = "https://github.com/" .. yanked_string
        vim.api.nvim_call_function("netrw#BrowseX", { github_url, 0 })
        print(github_url)
      end)
    end, {})
  end,
})
