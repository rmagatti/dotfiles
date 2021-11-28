local M = {
  conf = {
    debug = false,
  },
}

M.setup = function(config)
  M.debug = vim.tbl_deep_extend("force", M.conf, config or {})

  -- TODO: move these
  vim.cmd [[
    " Git Edit Modified
    nnoremap <leader>gem <cmd>lua require('rmagatti.git-helpers').edit_modified()<CR>
    " Git Edit All
    nnoremap <leader>gea <cmd>lua require('rmagatti.git-helpers').edit_all()<CR>
  ]]
end

local cmd = function()
  return vim.fn.system "git status --porcelain"
end

local logger = {
  debug = function(...)
    if M.conf.debug then
      print("git-helpers:", ...)
    end
  end,
}

M.edit = function(type)
  local status = cmd()
  logger.debug("status: ", vim.inspect(status))
  local changes = vim.split(vim.trim(status), "\n")

  for _, change in ipairs(changes) do
    local change_type = vim.trim(change:sub(1, 1))
    local file_path = vim.trim(change:sub(3))

    logger.debug(change_type, file_path)

    if type == "all" then
      vim.cmd("edit " .. file_path)
    elseif change_type == type then
      logger.debug("editing", change_type, file_path)
      vim.cmd("edit " .. file_path)
    end
  end
end

M.edit_modified = function()
  M.edit "M"
end
M.edit_staged = function()
  M.edit "A"
end
M.edit_all = function()
  M.edit "all"
end

return M
