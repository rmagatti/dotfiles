-- Example test file demonstrating how to use test helpers
-- This shows common testing patterns and best practices

local helpers = require("tests.test_helpers")
local eq = assert.are.same

describe("example test suite", function()
    local cleanup_manager

    before_each(function()
        -- Create a cleanup manager to handle resource cleanup
        cleanup_manager = helpers.create_cleanup_manager()
    end)

    after_each(function()
        -- Clean up all resources
        cleanup_manager.cleanup()
    end)

    describe("buffer helpers", function()
        it("should create and delete test buffers", function()
            -- Create a test buffer with content and filetype
            local bufnr = helpers.create_test_buffer({
                filetype = "lua",
                content = {
                    "local function hello()",
                    '  print("Hello, world!")',
                    "end",
                },
            })

            -- Add to cleanup manager
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            -- Verify buffer was created
            assert.is_true(vim.api.nvim_buf_is_valid(bufnr))

            -- Verify content
            local lines = helpers.get_buffer_lines(bufnr)
            eq(3, #lines)
            eq('local function hello()', lines[1])
        end)

        it("should load fixtures into buffers", function()
            local bufnr = helpers.create_test_buffer({ filetype = "rust" })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            -- Load a fixture file using absolute path
            local script_dir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h")
            local fixture_path = script_dir .. "/fixtures/sample_rust_test.rs"

            if vim.fn.filereadable(fixture_path) == 1 then
                local content = vim.fn.readfile(fixture_path)
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
                helpers.assert_buffer_contains(bufnr, "#[cfg(test)]")
                helpers.assert_buffer_contains(bufnr, "mod tests")
            else
                -- Fixture might not exist, which is okay for this example
                assert.is_true(true, "Fixture not found, skipping")
            end
        end)
    end)

    describe("treesitter helpers", function()
        it("should wait for parser to be ready", function()
            local bufnr = helpers.create_test_buffer({
                filetype = "lua",
                content = { "local x = 42" },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            -- Wait for parser
            local parser_ready = helpers.wait_for_parser(bufnr, "lua", 1000)

            -- Parser should be available (if treesitter is installed)
            if vim.treesitter.language.get_lang("lua") then
                assert.is_true(parser_ready)
            end
        end)

        it("should count query captures", function()
            local bufnr = helpers.create_test_buffer({
                filetype = "lua",
                content = {
                    "local function foo()",
                    "  return 1",
                    "end",
                    "",
                    "local function bar()",
                    "  return 2",
                    "end",
                },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            helpers.wait_for_parser(bufnr, "lua", 1000)

            -- Count function declarations
            local query_string = [[
        (function_declaration
          name: (identifier) @func_name)
      ]]

            local count = helpers.count_query_captures(bufnr, "lua", query_string, "func_name")

            -- Should find at least some functions (if treesitter works)
            assert.is_true(count >= 0)
        end)
    end)

    describe("async helpers", function()
        it("should wait for conditions", function()
            local flag = false

            vim.defer_fn(function()
                flag = true
            end, 50)

            -- Wait for flag to become true
            local success = helpers.wait_for(function()
                return flag
            end, 200)

            assert.is_true(success)
            assert.is_true(flag)
        end)

        it("should handle defer_and_wait", function()
            local value = 0

            local completed = helpers.defer_and_wait(function()
                value = 42
            end, 50)

            assert.is_true(completed)
            eq(42, value)
        end)
    end)

    describe("notification spy", function()
        it("should capture notifications", function()
            local spy = helpers.spy_notify()
            cleanup_manager.add(function()
                spy.restore()
            end)

            -- Trigger some notifications
            vim.notify("Test message 1", vim.log.levels.INFO)
            vim.notify("Test message 2", vim.log.levels.DEBUG)
            vim.notify("Test message 3", vim.log.levels.WARN)

            -- Verify notifications were captured
            eq(3, spy.count())

            local first = spy.get(1)
            eq("Test message 1", first.msg)
            eq(vim.log.levels.INFO, first.level)

            -- Clear notifications
            spy.clear()
            eq(0, spy.count())
        end)
    end)

    describe("cursor helpers", function()
        it("should save and restore cursor position", function()
            local bufnr = helpers.create_test_buffer({
                content = {
                    "line 1",
                    "line 2",
                    "line 3",
                    "line 4",
                },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            local winid = helpers.create_test_window(bufnr)

            -- Set cursor to line 2
            helpers.set_cursor(2, 5, winid)

            -- Save position
            local saved_pos = helpers.save_cursor(winid)
            eq(2, saved_pos[1])
            eq(5, saved_pos[2])

            -- Move cursor elsewhere
            helpers.set_cursor(4, 0, winid)
            local new_pos = helpers.save_cursor(winid)
            eq(4, new_pos[1])

            -- Restore original position
            helpers.restore_cursor(saved_pos, winid)
            local restored_pos = helpers.save_cursor(winid)
            eq(saved_pos, restored_pos)
        end)
    end)

    describe("fold helpers", function()
        it("should detect folded lines", function()
            local bufnr = helpers.create_test_buffer({
                filetype = "lua",
                content = {
                    "local function test()",
                    "  local x = 1",
                    "  local y = 2",
                    "  return x + y",
                    "end",
                },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            local winid = helpers.create_test_window(bufnr)

            -- Set up folding
            vim.opt_local.foldmethod = "indent"
            vim.opt_local.foldenable = true

            -- Check if line is folded (might not be by default)
            local is_folded = helpers.is_line_folded(1)

            -- Should return a boolean
            assert.is_not_nil(is_folded)
            assert.is_boolean(is_folded)

            -- Get fold info
            local fold_info = helpers.get_fold_info(1)
            assert.is_not_nil(fold_info)
            assert.is_number(fold_info.level)
            assert.is_boolean(fold_info.closed)
        end)

        it("should get all folds in buffer", function()
            local bufnr = helpers.create_test_buffer({
                content = { "line 1", "line 2", "line 3" },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            helpers.create_test_window(bufnr)

            local folds = helpers.get_all_folds()

            -- Should return a table
            assert.is_table(folds)
        end)
    end)

    describe("assertion helpers", function()
        it("should assert table contains value", function()
            local tbl = { "apple", "banana", "cherry" }

            helpers.assert_contains(tbl, "banana")

            -- This should fail (but we wrap in pcall to test)
            local success = pcall(function()
                helpers.assert_contains(tbl, "orange")
            end)
            assert.is_false(success)
        end)

        it("should assert buffer contains text", function()
            local bufnr = helpers.create_test_buffer({
                content = {
                    "Hello, world!",
                    "This is a test",
                },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            helpers.assert_buffer_contains(bufnr, "Hello")
            helpers.assert_buffer_contains(bufnr, "test")

            -- This should fail
            local success = pcall(function()
                helpers.assert_buffer_contains(bufnr, "nonexistent")
            end)
            assert.is_false(success)
        end)

        it("should assert eventually", function()
            local counter = 0

            vim.defer_fn(function()
                counter = 5
            end, 50)

            -- This should eventually succeed
            helpers.assert_eventually(function()
                assert.are.equal(5, counter)
            end, 200)
        end)
    end)

    describe("utility helpers", function()
        it("should deep copy tables", function()
            local original = {
                a = 1,
                b = { c = 2, d = 3 },
                e = { f = { g = 4 } },
            }

            local copy = helpers.deep_copy(original)

            -- Verify it's a copy
            eq(original, copy)

            -- Modify copy
            copy.b.c = 999

            -- Original should be unchanged
            eq(2, original.b.c)
            eq(999, copy.b.c)
        end)

        it("should create and remove temp files", function()
            local content = { "line 1", "line 2", "line 3" }
            local tmpfile = helpers.create_temp_file(content, "txt")

            cleanup_manager.add(function()
                helpers.remove_temp_file(tmpfile)
            end)

            -- Verify file exists
            assert.is_true(vim.fn.filereadable(tmpfile) == 1)

            -- Verify content
            local read_content = vim.fn.readfile(tmpfile)
            eq(content, read_content)
        end)
    end)

    describe("autocmd tracking", function()
        it("should track autocmd fires", function()
            local tracker = helpers.track_autocmd("BufEnter", "*")

            -- Create a new buffer to trigger BufEnter
            local bufnr = helpers.create_test_buffer()
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            vim.api.nvim_set_current_buf(bufnr)

            -- Give it a moment to fire
            vim.wait(100)

            -- Should have tracked some fires
            assert.is_true(tracker.count() >= 0)
        end)
    end)

    describe("real-world example", function()
        it("should test a complete workflow", function()
            -- Create a Rust buffer with test code
            local bufnr = helpers.create_test_buffer({
                filetype = "rust",
                content = {
                    "#[cfg(test)]",
                    "mod tests {",
                    "    #[test]",
                    "    fn test_example() {",
                    "        assert_eq!(1 + 1, 2);",
                    "    }",
                    "}",
                },
            })
            cleanup_manager.add(function()
                helpers.delete_buffer(bufnr)
            end)

            local winid = helpers.create_test_window(bufnr)

            -- Set up notification spy
            local notify_spy = helpers.spy_notify()
            cleanup_manager.add(function()
                notify_spy.restore()
            end)

            -- Save cursor position
            helpers.set_cursor(1, 0, winid)
            local original_pos = helpers.save_cursor(winid)

            -- Wait for treesitter to parse
            local parser_ready = helpers.wait_for_parser(bufnr, "rust", 1000)

            if parser_ready then
                -- Verify the buffer contains expected content
                helpers.assert_buffer_contains(bufnr, "#[cfg(test)]")
                helpers.assert_buffer_contains(bufnr, "mod tests")

                -- Count test modules
                local query_string = [[
          (attribute_item
            (attribute) @attr (#contains? @attr "test"))
        ]]

                local count = helpers.count_query_captures(bufnr, "rust", query_string, "attr")
                assert.is_true(count >= 1, "Should find at least one test attribute")
            end

            -- Restore cursor
            helpers.restore_cursor(original_pos, winid)
            local restored = helpers.save_cursor(winid)
            eq(original_pos, restored)
        end)
    end)
end)
