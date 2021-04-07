-- TODO: make this thing into a plugin
local path = require('telescope.path')
local utils = require('telescope.utils')
local themes = require('telescope.themes')

local make_entry = {}

do
  local lookup_keys = {
    ordinal = 1,
    value = 1,
    filename = 1,
    cwd = 2,
  }

  function make_entry.gen_from_file(opts)
    opts = opts or {}

    local cwd = vim.fn.expand(opts.cwd or vim.fn.getcwd())

    local shorten_path = opts.shorten_path

    local mt_file_entry = {}

    mt_file_entry.cwd = cwd
    mt_file_entry.display = function(entry)
      -- Revert session files back to paths for easier reading
      -- This affects the display only, a selection still uses the correct file name.
      local display = path.make_relative((entry.value:gsub("%%", "/")), cwd)
      if shorten_path then
        display = utils.path_shorten(display)
      end
      -- Strip file extensions since sessions always have the same .vim extension.
      local filename_only = display:match("(.+)%..+")

      return filename_only
    end

    -- No idea what this block does, got it from the telescope code, may or may not figure it out later.
    mt_file_entry.__index = function(t, k)
      local raw = rawget(mt_file_entry, k)
      if raw then return raw end

      if k == "path" then
        local retpath = t.cwd .. path.separator .. t.value
        if not vim.loop.fs_access(retpath, "R", nil) then
          retpath = t.value
        end
        return retpath
      end

      return rawget(t, rawget(lookup_keys, k))
    end

    return function(line)
      return setmetatable({line}, mt_file_entry)
    end
  end
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function source_session(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.cmd("RestoreSession "..selection.path)
end

local M = {}
M.search_sessions = function()
  local cwd = require('auto-session').conf.root_dir
  local shorten_path = true
  local theme_opts = themes.get_dropdown({winblend= 10, border= true, previewer=false})
  local opts = {
    shorten_path = shorten_path,
    prompt_title = 'Sessions',
    entry_maker = make_entry.gen_from_file({cwd = cwd, shorten_path = shorten_path}),
    cwd = cwd,
    attach_mappings = function()
      actions.select_default:replace(source_session)
      return true
    end,
  }

  require("telescope.builtin").find_files(vim.tbl_deep_extend("force", opts, theme_opts))
end
return M
