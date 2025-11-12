-- Configuration
local M = {}
M.debug = false          -- Set to true to enable debug logging
M.processed_buffers = {} -- Track which buffers have been folded

local function log(msg)
    if M.debug then
        print(msg)
    end
end

local function fold_rust_tests_cfg()
    local bufnr = vim.api.nvim_get_current_buf()
    log(string.format("[rust-fold] Starting fold_rust_tests_cfg for buffer %d", bufnr))

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

    log("[rust-fold] Folding Rust test modules based on #[cfg(test)]...")

    local parser = vim.treesitter.get_parser(bufnr, "rust")
    if not parser then
        log("[rust-fold] ERROR: No parser available for rust")
        return
    end
    log("[rust-fold] Parser found successfully")

    local tree = parser:parse()[1]
    if not tree then
        log("[rust-fold] ERROR: No parse tree available")
        return
    end
    log("[rust-fold] Parse tree obtained successfully")
    local root = tree:root()

    local capture_count = 0
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        capture_count = capture_count + 1
        local capture_name = query.captures[id]
        log(string.format("[rust-fold] Capture #%d: %s", capture_count, capture_name))

        if node and capture_name == "modName" then
            local s, _, e, _ = node:range() -- 0-indexed values
            local fold_line = s + 1         -- Convert to Vim's 1-indexed line number
            log(string.format("[rust-fold] Found test module at line %d (range: %d-%d)", fold_line, s, e))

            -- Check current fold settings
            local foldmethod = vim.opt_local.foldmethod:get()
            local foldexpr = vim.opt_local.foldexpr:get()
            log(string.format("[rust-fold] Current fold settings: method=%s, expr=%s", foldmethod, foldexpr))

            -- Save the current cursor position.
            local cur_pos = vim.api.nvim_win_get_cursor(0)
            log(string.format("[rust-fold] Saved cursor position: line=%d, col=%d", cur_pos[1], cur_pos[2]))

            -- Move the cursor to the start of the test module.
            vim.api.nvim_win_set_cursor(0, { fold_line, 0 })
            log(string.format("[rust-fold] Moved cursor to line %d", fold_line))

            -- Check fold level at this line
            local foldlevel_before = vim.fn.foldlevel(fold_line)
            log(string.format("[rust-fold] Fold level at line %d: %d", fold_line, foldlevel_before))

            -- Recalculate folds (this forces the foldexpr to update).
            vim.cmd("normal! zx")
            log("[rust-fold] Executed 'zx' to recalculate folds")

            -- Check if the line can be folded
            local foldclosed = vim.fn.foldclosed(fold_line)
            local foldclosedend = vim.fn.foldclosedend(fold_line)
            log(string.format("[rust-fold] Before fold - foldclosed: %d, foldclosedend: %d", foldclosed, foldclosedend))

            -- Try to close the fold at the current cursor line.
            local success, err = pcall(vim.cmd, "normal! zc")
            if success then
                log("[rust-fold] Executed 'zc' to close fold")
            else
                log(string.format("[rust-fold] ERROR executing 'zc': %s", err))
            end

            -- Check if fold was actually closed
            foldclosed = vim.fn.foldclosed(fold_line)
            foldclosedend = vim.fn.foldclosedend(fold_line)
            log(string.format("[rust-fold] After fold - foldclosed: %d, foldclosedend: %d", foldclosed, foldclosedend))

            if foldclosed == -1 then
                log(string.format("[rust-fold] WARNING: Line %d was NOT folded (foldclosed=-1)", fold_line))
            else
                log(string.format("[rust-fold] SUCCESS: Folded lines %d-%d", foldclosed, foldclosedend))
            end

            -- Restore your original cursor position.
            vim.api.nvim_win_set_cursor(0, cur_pos)
            log(string.format("[rust-fold] Restored cursor to line=%d, col=%d", cur_pos[1], cur_pos[2]))
        end
    end

    if capture_count == 0 then
        log("[rust-fold] WARNING: No captures found by treesitter query")
    else
        log(string.format("[rust-fold] Total captures found: %d", capture_count))
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Check if we've already processed this buffer
        if M.processed_buffers[bufnr] then
            log(string.format("[rust-fold] Buffer %d already processed, skipping", bufnr))
            return
        end

        log(string.format("[rust-fold] FileType autocmd triggered for buffer %d", bufnr))

        -- Delay a bit to ensure Tree‑sitter has parsed the file.
        vim.defer_fn(function()
            log("[rust-fold] Defer callback executing (after 500ms delay)")

            -- Save original fold settings and apply them after the fold.
            local original_foldmethod = vim.opt_local.foldmethod
            local original_foldexpr = vim.opt_local.foldexpr
            local original_foldtext = vim.opt_local.foldtext

            log(string.format("[rust-fold] Original fold settings: method=%s, expr=%s",
                original_foldmethod:get(), original_foldexpr:get()))

            -- Set buffer-local fold settings
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"
            log("[rust-fold] Set treesitter fold settings")

            vim.cmd("normal! zx")
            log("[rust-fold] Recalculated folds with 'zx'")

            -- Apply the folding
            log("[rust-fold] Calling fold_rust_tests_cfg()...")
            fold_rust_tests_cfg()

            -- Switch to manual fold method to preserve the folds we just created
            -- If we restore the original foldexpr, the manually closed folds will be lost
            log("[rust-fold] Switching to manual foldmethod to preserve folds")
            vim.opt_local.foldmethod = "manual"

            -- Keep the nice foldtext if we had treesitter, otherwise restore original
            if original_foldtext:get() ~= "v:lua.vim.treesitter.foldtext()" then
                vim.opt_local.foldtext = original_foldtext
                log(string.format("[rust-fold] Restored original foldtext: %s", original_foldtext:get()))
            else
                log("[rust-fold] Keeping treesitter foldtext")
            end

            log(string.format("[rust-fold] Final fold settings: method=%s",
                vim.opt_local.foldmethod:get()))
            log("[rust-fold] Folding process complete - folds preserved in manual mode")

            -- Mark this buffer as processed
            M.processed_buffers[bufnr] = true
        end, 500)
    end,
})

-- Clean up processed buffer tracking when buffer is deleted
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(args)
        M.processed_buffers[args.buf] = nil
    end,
})

-- User command to manually trigger folding (useful for debugging or re-folding)
vim.api.nvim_create_user_command("RustFoldTests", function()
    local bufnr = vim.api.nvim_get_current_buf()
    M.processed_buffers[bufnr] = nil -- Clear the flag
    fold_rust_tests_cfg()
    M.processed_buffers[bufnr] = true
end, { desc = "Manually fold Rust test modules" })

-- User command to toggle debug logging
vim.api.nvim_create_user_command("RustFoldDebug", function(opts)
    if opts.args == "on" then
        M.debug = true
        print("[rust-fold] Debug logging enabled")
    elseif opts.args == "off" then
        M.debug = false
        print("[rust-fold] Debug logging disabled")
    else
        M.debug = not M.debug
        print(string.format("[rust-fold] Debug logging %s", M.debug and "enabled" or "disabled"))
    end
end, { nargs = "?", complete = function() return { "on", "off" } end, desc = "Toggle Rust fold debug logging" })
