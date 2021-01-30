-- directory path including last slash /
DEFAULT_SESSIONS_DIR = "~/.config/nvim/sessions/"
local M = {}

local function getProjectDir()
  local cwd = vim.fn.getcwd()
  local project_dir = cwd:gsub("/", "-")
  return project_dir
end

function M.SaveSession(sessions_dir)
  if vim.fn.empty("argv()") then
    local sessions_dir = sessions_dir or DEFAULT_SESSIONS_DIR
    local project_dir = getProjectDir()
    local cmd = "mks! ".. string.format(sessions_dir.."%s.vim", project_dir)

    print(cmd)
    vim.cmd(cmd)
  end
end

function M.RestoreSession(sessions_dir)
  if next(vim.fn.argv()) == nil then
    local sessions_dir = sessions_dir or DEFAULT_SESSIONS_DIR
    local project_dir = getProjectDir()
    local session_file_path = string.format(sessions_dir.."%s.vim", project_dir)

    if vim.fn.filereadable(session_file_path) then
      local cmd = "source "..session_file_path

      print(cmd)
      vim.cmd(cmd)
    else
      print("Session file does not exist or is not readable. Skipping session loading.")
    end
  else
    print("Skipping session loading, argv not empty.")
  end
end

return M
