-- Alternative approach: Persistent test module folding with auto-refolding
-- This version maintains fold state and re-applies folds when needed

local M = {}

-- Store fold information per buffer
M.buffer_folds = {}

-- Find all test module line ranges in the buffer
local function find_test_module_ranges(bufnr)
    local ranges = {}

    local query = vim.treesitter.query.parse("rust", [[
      (
        (attribute_item
          (attribute) @attr (#contains? @attr "test")
          ) @attrItem
        (mod_item
          name: (identifier) @modName)
        (#contains? @modName "test")
      ) @captureName
    ]])

    local parser = vim.treesitter.get_parser(bufnr, "rust")
    if not parser then
        print("[rust-fold-alt] ERROR: No parser available for rust")
        return ranges
    end

    local tree = parser:parse()[1]
    if not tree then
        print("[rust-fold-alt] ERROR: No parse tree available")
        return ranges
    end

    local root = tree:root()

    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        if node and query.captures[id] == "captureName" then
            local start_row, _, end_row, _ = node:range()
            table.insert(ranges, {
                start_line = start_row + 1, -- Convert to 1-indexed
                end_line = end_row + 1,
            })
            print(string.format("[rust-fold-alt] Found test module: lines %d-%d", start_row + 1, end_row + 1))
        end
    end

    return ranges
end

-- Apply folds to specific line ranges
local function apply_folds(bufnr, ranges)
    if #ranges == 0 then
        print("[rust-fold-alt] No ranges to fold")
        return
    end

    print(string.format("[rust-fold-alt] Applying %d folds", #ranges))

    -- Save current cursor position and window
    local cur_win = vim.api.nvim_get_current_win()
    local cur_pos = vim.api.nvim_win_get_cursor(cur_win)

    for _, range in ipairs(ranges) do
        -- Move cursor to the start of the range
        vim.api.nvim_win_set_cursor(cur_win, { range.start_line, 0 })

        -- Create a manual fold
        vim.cmd(string.format("%d,%dfold", range.start_line, range.end_line))

        print(string.format("[rust-fold-alt] Created fold for lines %d-%d", range.start_line, range.end_line))
    end

    -- Restore cursor position
    vim.api.nvim_win_set_cursor(cur_win, cur_pos)
    print("[rust-fold-alt] Folds applied successfully")
end

-- Main function to setup folding for a buffer
function M.setup_buffer_folding(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    print(string.format("[rust-fold-alt] Setting up folding for buffer %d", bufnr))

    -- Find test module ranges
    local ranges = find_test_module_ranges(bufnr)
    if #ranges == 0 then
        print("[rust-fold-alt] No test modules found")
        return
    end

    -- Store ranges for this buffer
    M.buffer_folds[bufnr] = ranges

    -- Switch to manual fold method
    vim.opt_local.foldmethod = "manual"

    -- Clear existing folds
    vim.cmd("normal! zE")

    -- Apply the folds
    apply_folds(bufnr, ranges)

    -- Close the folds
    for _, range in ipairs(ranges) do
        local foldclosed = vim.fn.foldclosed(range.start_line)
        if foldclosed == -1 then
            vim.api.nvim_win_set_cursor(0, { range.start_line, 0 })
            vim.cmd("normal! zc")
            print(string.format("[rust-fold-alt] Closed fold at line %d", range.start_line))
        end
    end

    print("[rust-fold-alt] Buffer folding setup complete")
end

-- Reapply folds (useful when folds are lost)
function M.reapply_folds(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    if not M.buffer_folds[bufnr] or #M.buffer_folds[bufnr] == 0 then
        print("[rust-fold-alt] No stored folds for this buffer, running setup")
        M.setup_buffer_folding(bufnr)
        return
    end

    print(string.format("[rust-fold-alt] Reapplying %d folds", #M.buffer_folds[bufnr]))

    -- Ensure we're in manual fold mode
    if vim.opt_local.foldmethod:get() ~= "manual" then
        vim.opt_local.foldmethod = "manual"
    end

    -- Clear and reapply
    vim.cmd("normal! zE")
    apply_folds(bufnr, M.buffer_folds[bufnr])

    -- Close them
    for _, range in ipairs(M.buffer_folds[bufnr]) do
        vim.api.nvim_win_set_cursor(0, { range.start_line, 0 })
        vim.cmd("normal! zc")
    end

    print("[rust-fold-alt] Folds reapplied")
end

-- Refresh folds (re-scan and reapply)
function M.refresh_folds(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    print("[rust-fold-alt] Refreshing folds")

    -- Clear stored folds
    M.buffer_folds[bufnr] = nil

    -- Setup fresh
    M.setup_buffer_folding(bufnr)
end

-- Setup autocmds
local function setup_autocmds()
    local augroup = vim.api.nvim_create_augroup("RustTestFoldingAlt", { clear = true })

    -- Initial setup when opening a Rust file
    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "rust",
        callback = function(args)
            print(string.format("[rust-fold-alt] FileType autocmd triggered for buffer %d", args.buf))

            -- Delay to ensure treesitter is ready
            vim.defer_fn(function()
                M.setup_buffer_folding(args.buf)
            end, 500)
        end,
    })

    -- Reapply folds when fold settings might have changed
    vim.api.nvim_create_autocmd("OptionSet", {
        group = augroup,
        pattern = "foldmethod",
        callback = function(args)
            if vim.bo[args.buf].filetype == "rust" then
                print("[rust-fold-alt] foldmethod changed, checking if reapply needed")
                -- Only reapply if we have stored folds and method changed away from manual
                if M.buffer_folds[args.buf] and vim.opt_local.foldmethod:get() ~= "manual" then
                    vim.defer_fn(function()
                        M.reapply_folds(args.buf)
                    end, 100)
                end
            end
        end,
    })

    -- Clean up when buffer is deleted
    vim.api.nvim_create_autocmd("BufDelete", {
        group = augroup,
        callback = function(args)
            M.buffer_folds[args.buf] = nil
        end,
    })
end

-- User commands for manual control
local function setup_commands()
    vim.api.nvim_create_user_command("RustFoldTestModules", function()
        M.setup_buffer_folding()
    end, { desc = "Fold all Rust test modules in current buffer" })

    vim.api.nvim_create_user_command("RustRefoldTestModules", function()
        M.refresh_folds()
    end, { desc = "Refresh folds for Rust test modules" })

    vim.api.nvim_create_user_command("RustReapplyFolds", function()
        M.reapply_folds()
    end, { desc = "Reapply stored folds" })

    vim.api.nvim_create_user_command("RustUnfoldTestModules", function()
        local bufnr = vim.api.nvim_get_current_buf()
        M.buffer_folds[bufnr] = nil
        vim.cmd("normal! zE")
        print("[rust-fold-alt] Cleared all folds")
    end, { desc = "Clear all Rust test module folds" })
end

-- Initialize the module
setup_autocmds()
setup_commands()

print("[rust-fold-alt] Alternative Rust test folding loaded")
print(
"[rust-fold-alt] Available commands: :RustFoldTestModules, :RustRefoldTestModules, :RustReapplyFolds, :RustUnfoldTestModules")

return M
