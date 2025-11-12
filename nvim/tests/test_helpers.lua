-- Test helpers and utilities for Neovim testing
-- This module provides common functions to make writing tests easier

local M = {}

-- Buffer Helpers --

--- Create a test buffer with optional content and filetype
--- @param opts table Options: { filetype: string, content: table, scratch: boolean }
--- @return number bufnr The created buffer number
function M.create_test_buffer(opts)
    opts = opts or {}
    local bufnr = vim.api.nvim_create_buf(false, opts.scratch ~= false)

    if opts.filetype then
        vim.api.nvim_buf_set_option(bufnr, "filetype", opts.filetype)
    end

    if opts.content then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, opts.content)
    end

    return bufnr
end

--- Clean up a buffer safely
--- @param bufnr number The buffer to delete
function M.delete_buffer(bufnr)
    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
    end
end

--- Get all lines from a buffer
--- @param bufnr number The buffer number
--- @return table lines The buffer lines
function M.get_buffer_lines(bufnr)
    return vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
end

-- Window Helpers --

--- Create a test window with a buffer
--- @param bufnr number Optional buffer to display in window
--- @return number winid The created window ID
function M.create_test_window(bufnr)
    local current_win = vim.api.nvim_get_current_win()
    if bufnr then
        vim.api.nvim_win_set_buf(current_win, bufnr)
    end
    return current_win
end

--- Close a window safely
--- @param winid number The window to close
function M.close_window(winid)
    if winid and vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_close(winid, true)
    end
end

-- Fixture Helpers --

--- Load content from a fixture file
--- @param filename string The fixture filename (relative to tests/fixtures/)
--- @return table|nil lines The file content or nil if not found
function M.load_fixture(filename)
    -- Get the directory of the calling script (should be in tests/)
    local info = debug.getinfo(2, "S")
    local script_path = info and info.source and info.source:sub(2) or ""
    local script_dir = vim.fn.fnamemodify(script_path, ":h")

    local fixture_path = script_dir .. "/fixtures/" .. filename
    if vim.fn.filereadable(fixture_path) == 1 then
        return vim.fn.readfile(fixture_path)
    end
    return nil
end

--- Load fixture into a buffer
--- @param bufnr number The buffer to load into
--- @param filename string The fixture filename
--- @return boolean success Whether the fixture was loaded
function M.load_fixture_into_buffer(bufnr, filename)
    local content = M.load_fixture(filename)
    if content then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
        return true
    end
    return false
end

-- TreeSitter Helpers --

--- Wait for treesitter parser to be ready
--- @param bufnr number The buffer number
--- @param lang string The language (e.g., "rust", "lua")
--- @param timeout number Timeout in milliseconds (default: 500)
--- @return boolean success Whether parser became available
function M.wait_for_parser(bufnr, lang, timeout)
    timeout = timeout or 500
    return vim.wait(timeout, function()
        local parser = vim.treesitter.get_parser(bufnr, lang)
        return parser ~= nil
    end, 10)
end

--- Get the treesitter root node for a buffer
--- @param bufnr number The buffer number
--- @param lang string The language
--- @return table|nil root The root node or nil
function M.get_tree_root(bufnr, lang)
    local parser = vim.treesitter.get_parser(bufnr, lang)
    if not parser then
        return nil
    end

    local trees = parser:parse()
    if not trees or #trees == 0 then
        return nil
    end

    return trees[1]:root()
end

--- Count captures matching a query
--- @param bufnr number The buffer number
--- @param lang string The language
--- @param query_string string The treesitter query
--- @param capture_name string The capture name to count
--- @return number count The number of matches
function M.count_query_captures(bufnr, lang, query_string, capture_name)
    local root = M.get_tree_root(bufnr, lang)
    if not root then
        return 0
    end

    local query = vim.treesitter.query.parse(lang, query_string)
    local count = 0

    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        if query.captures[id] == capture_name then
            count = count + 1
        end
    end

    return count
end

-- Async Helpers --

--- Wait for a condition with timeout
--- @param condition function Function that returns true when ready
--- @param timeout number Timeout in milliseconds (default: 1000)
--- @param interval number Check interval in milliseconds (default: 10)
--- @return boolean success Whether condition was met
function M.wait_for(condition, timeout, interval)
    timeout = timeout or 1000
    interval = interval or 10
    return vim.wait(timeout, condition, interval)
end

--- Run a function with defer_fn and wait for completion
--- @param func function The function to run
--- @param delay number Delay in milliseconds
--- @param timeout number Timeout in milliseconds (default: delay * 2)
--- @return boolean success Whether function completed
function M.defer_and_wait(func, delay, timeout)
    timeout = timeout or (delay * 2 + 100)
    local completed = false

    vim.defer_fn(function()
        func()
        completed = true
    end, delay)

    return vim.wait(timeout, function()
        return completed
    end, 10)
end

-- Mock Helpers --

--- Create a spy for vim.notify to capture notifications
--- @return table spy The spy object with captured notifications
function M.spy_notify()
    local notifications = {}
    local original_notify = vim.notify

    vim.notify = function(msg, level, opts)
        table.insert(notifications, {
            msg = msg,
            level = level or vim.log.levels.INFO,
            opts = opts,
        })
        -- Still call original for visibility if needed
        -- original_notify(msg, level, opts)
    end

    return {
        notifications = notifications,
        restore = function()
            vim.notify = original_notify
        end,
        clear = function()
            notifications = {}
        end,
        count = function()
            return #notifications
        end,
        get = function(index)
            return notifications[index]
        end,
    }
end

--- Mock an autocommand to track when it fires
--- @param event string|table The event(s) to track
--- @param pattern string|table The pattern(s) to match
--- @return table tracker Object to track autocmd fires
function M.track_autocmd(event, pattern)
    local fires = {}

    vim.api.nvim_create_autocmd(event, {
        pattern = pattern,
        callback = function(args)
            table.insert(fires, {
                event = args.event,
                buf = args.buf,
                file = args.file,
                match = args.match,
            })
        end,
    })

    return {
        fires = fires,
        count = function()
            return #fires
        end,
        get = function(index)
            return fires[index]
        end,
        clear = function()
            fires = {}
        end,
    }
end

-- Assertion Helpers --

--- Assert that a table contains a value
--- @param tbl table The table to search
--- @param value any The value to find
--- @param msg string Optional error message
function M.assert_contains(tbl, value, msg)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    error(msg or string.format("Table does not contain value: %s", vim.inspect(value)))
end

--- Assert that a buffer contains text
--- @param bufnr number The buffer number
--- @param text string The text to find
--- @param msg string Optional error message
function M.assert_buffer_contains(bufnr, text, msg)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local content = table.concat(lines, "\n")
    if not content:find(text, 1, true) then
        error(msg or string.format("Buffer does not contain text: %s", text))
    end
end

--- Assert that a function eventually succeeds
--- @param func function The function to test
--- @param timeout number Timeout in milliseconds (default: 1000)
--- @param msg string Optional error message
function M.assert_eventually(func, timeout, msg)
    timeout = timeout or 1000
    local success = vim.wait(timeout, function()
        local ok = pcall(func)
        return ok
    end, 10)

    if not success then
        error(msg or "Function did not succeed within timeout")
    end
end

-- Cursor Helpers --

--- Save current cursor position
--- @param winid number Optional window ID (default: current window)
--- @return table position The cursor position [row, col]
function M.save_cursor(winid)
    winid = winid or 0
    return vim.api.nvim_win_get_cursor(winid)
end

--- Restore cursor position
--- @param position table The position to restore [row, col]
--- @param winid number Optional window ID (default: current window)
function M.restore_cursor(position, winid)
    winid = winid or 0
    vim.api.nvim_win_set_cursor(winid, position)
end

--- Set cursor to a specific line and column
--- @param line number 1-indexed line number
--- @param col number 0-indexed column number
--- @param winid number Optional window ID (default: current window)
function M.set_cursor(line, col, winid)
    winid = winid or 0
    vim.api.nvim_win_set_cursor(winid, { line, col or 0 })
end

-- Fold Helpers --

--- Get fold info for a line
--- @param line number The line number (1-indexed)
--- @return table info Fold information { level, start, end }
function M.get_fold_info(line)
    local foldlevel = vim.fn.foldlevel(line)
    local foldclosed = vim.fn.foldclosed(line)
    local foldclosedend = vim.fn.foldclosedend(line)

    return {
        level = foldlevel,
        closed = foldclosed ~= -1,
        start = foldclosed,
        ["end"] = foldclosedend,
    }
end

--- Check if a line is folded
--- @param line number The line number (1-indexed)
--- @return boolean folded Whether the line is folded
function M.is_line_folded(line)
    return vim.fn.foldclosed(line) ~= -1
end

--- Get all folded line ranges in current buffer
--- @return table ranges List of { start, end } fold ranges
function M.get_all_folds()
    local folds = {}
    local lines = vim.api.nvim_buf_line_count(0)
    local i = 1

    while i <= lines do
        local closed = vim.fn.foldclosed(i)
        if closed ~= -1 then
            local closed_end = vim.fn.foldclosedend(i)
            table.insert(folds, { start = closed, ["end"] = closed_end })
            i = closed_end + 1
        else
            i = i + 1
        end
    end

    return folds
end

-- Cleanup Helpers --

--- Create a cleanup manager for tests
--- @return table manager Cleanup manager with add() and cleanup() methods
function M.create_cleanup_manager()
    local items = {}

    return {
        add = function(func)
            table.insert(items, func)
        end,
        cleanup = function()
            for i = #items, 1, -1 do
                pcall(items[i])
            end
            items = {}
        end,
    }
end

-- Utility Helpers --

--- Deep copy a table
--- @param orig table The table to copy
--- @return table copy The copied table
function M.deep_copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[M.deep_copy(orig_key)] = M.deep_copy(orig_value)
        end
        setmetatable(copy, M.deep_copy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

--- Create a temporary file with content
--- @param content table Lines of content
--- @param extension string File extension (default: "txt")
--- @return string path The temporary file path
function M.create_temp_file(content, extension)
    extension = extension or "txt"
    local tmpname = vim.fn.tempname() .. "." .. extension
    vim.fn.writefile(content, tmpname)
    return tmpname
end

--- Remove a temporary file
--- @param path string The file path to remove
function M.remove_temp_file(path)
    if vim.fn.filereadable(path) == 1 then
        vim.fn.delete(path)
    end
end

return M
