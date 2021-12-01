local M = {
  conf = {
    debug = false, -- print debug logs
    log_level = "info", -- log level for git-helpers
    run_copen = true, -- run copen after qf commands
    default_mappings = true, -- set default mappings
  },
}

M.setup = function(config)
  M.conf = vim.tbl_deep_extend("force", M.conf, config or {})

  if M.conf.default_mappings then
    vim.cmd [[
    nnoremap <leader>gem <cmd>lua require('rmagatti.git-helpers').edit_modified()<CR>
    nnoremap <leader>ges <cmd>lua require('rmagatti.git-helpers').edit_staged()<CR>
    nnoremap <leader>gea <cmd>lua require('rmagatti.git-helpers').edit_all()<CR>

    nnoremap <leader>gqm <cmd>lua require('rmagatti.git-helpers').qf_modified()<CR>
    nnoremap <leader>gqs <cmd>lua require('rmagatti.git-helpers').qf_staged()<CR>
    nnoremap <leader>gqa <cmd>lua require('rmagatti.git-helpers').qf_all()<CR>
  ]]
  end
end

local logger = {
  debug = function(...)
    if M.conf.debug then
      print("git-helpers:", ...)
    end
  end,
  info = function(...)
    if M.conf.debug or M.conf.log_level == "info" then
      print("git-helpers:", ...)
    end
  end,
}

local parse_changes = function()
  local status = vim.fn.system "git status --porcelain"
  logger.debug("status: ", vim.inspect(status))

  local changes = vim.split(vim.trim(status), "\n")

  return changes
end

M.qf_add = function(type)
  local changes = parse_changes()
  local qflist_what = {}

  for _, change in ipairs(changes) do
    local change_type = vim.trim(change:sub(1, 1))
    local file_path = vim.trim(change:sub(3))

    logger.debug(change_type, file_path)

    if type == "all" then
      local bufnr = vim.fn.bufadd(file_path)
      table.insert(qflist_what, { bufnr = bufnr, lnum = 0, col = 0 })
    elseif change_type == type then
      local bufnr = vim.fn.bufadd(file_path)
      table.insert(qflist_what, { bufnr = bufnr, lnum = 0, col = 0 })
    end
  end

  logger.debug("qflist_what: ", vim.inspect(qflist_what))
  if not vim.tbl_isempty(qflist_what) then
    logger.info "No changed files to parse"
    vim.fn.setqflist(qflist_what)
  end
  if M.conf.run_copen then
    vim.cmd [[copen]]
  end
end

M.edit = function(type)
  local changes = parse_changes()

  for _, change in ipairs(changes) do
    local change_type = vim.trim(change:sub(1, 1))
    local file_path = vim.trim(change:sub(3))

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

M.qf_modified = function()
  M.qf_add "M"
end
M.qf_staged = function()
  M.qf_add "A"
end
M.qf_all = function()
  M.qf_add "all"
end

return M
