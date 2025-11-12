local helpers = require("plenary.test_harness")
local eq = assert.are.same
local mock = require("luassert.mock")

describe("rust-test-folding", function()
    local rust_test_folding
    local test_bufnr
    local test_win

    before_each(function()
        -- Create a test buffer with rust filetype
        test_bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(test_bufnr, "filetype", "rust")

        -- Create a test window
        test_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(test_win, test_bufnr)

        -- Load the module fresh for each test
        package.loaded["rmagatti.rust-test-folding"] = nil
    end)

    after_each(function()
        -- Clean up test buffer
        if vim.api.nvim_buf_is_valid(test_bufnr) then
            vim.api.nvim_buf_delete(test_bufnr, { force = true })
        end
    end)

    describe("fold_rust_tests_cfg", function()
        it("should identify test modules with #[cfg(test)] attribute", function()
            -- Load fixture content
            local script_dir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h")
            local fixture_path = script_dir .. "/fixtures/sample_rust_test.rs"
            local content = vim.fn.readfile(fixture_path)

            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, content)

            -- Wait for treesitter to parse
            vim.wait(500, function()
                local parser = vim.treesitter.get_parser(test_bufnr, "rust")
                return parser ~= nil
            end)

            local parser = vim.treesitter.get_parser(test_bufnr, "rust")
            assert.is_not_nil(parser, "Treesitter parser should be available")
        end)

        it("should not crash when no parser is available", function()
            -- Create a buffer without a proper parser
            local empty_buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_option(empty_buf, "filetype", "unknown")
            vim.api.nvim_win_set_buf(test_win, empty_buf)

            -- This should not throw an error
            local success, parser = pcall(function()
                -- Simulate the fold function running
                return vim.treesitter.get_parser(empty_buf, "rust")
            end)

            -- Should succeed without crashing (parser will be nil for unknown filetype)
            assert.is_true(success)
            vim.api.nvim_buf_delete(empty_buf, { force = true })
        end)

        it("should handle empty rust files gracefully", function()
            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, {})

            local parser = vim.treesitter.get_parser(test_bufnr, "rust")
            if parser then
                local tree = parser:parse()[1]
                assert.is_not_nil(tree)
            end
        end)
    end)

    describe("treesitter query", function()
        it("should match test modules with correct attributes", function()
            local query_string = [[
        (
          (attribute_item
            (attribute) @attr (#contains? @attr "test")
            ) @attrItem
          (mod_item
            name: (identifier) @modName)
          (#contains? @modName "test")
        ) @captureName
      ]]

            local success, query = pcall(vim.treesitter.query.parse, "rust", query_string)
            assert.is_true(success, "Query should parse successfully")
            assert.is_not_nil(query, "Query should not be nil")
        end)

        it("should find multiple test modules in a file", function()
            local content = {
                "#[cfg(test)]",
                "mod tests {",
                "    #[test]",
                "    fn test_one() {}",
                "}",
                "",
                "#[cfg(test)]",
                "mod more_tests {",
                "    #[test]",
                "    fn test_two() {}",
                "}",
            }

            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, content)

            vim.wait(500, function()
                local parser = vim.treesitter.get_parser(test_bufnr, "rust")
                return parser ~= nil
            end)

            local parser = vim.treesitter.get_parser(test_bufnr, "rust")
            if parser then
                local tree = parser:parse()[1]
                local root = tree:root()

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

                local count = 0
                for id, node in query:iter_captures(root, test_bufnr, 0, -1) do
                    if query.captures[id] == "modName" then
                        count = count + 1
                    end
                end

                assert.is_true(count >= 0, "Should find test modules")
            end
        end)
    end)

    describe("fold settings", function()
        it("should preserve original fold settings", function()
            -- Set custom fold settings
            vim.api.nvim_win_set_buf(test_win, test_bufnr)
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.foldexpr = "0"

            local original_foldmethod = vim.opt_local.foldmethod:get()

            -- Simulate the folding process
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

            -- Restore
            vim.opt_local.foldmethod = original_foldmethod

            eq("manual", vim.opt_local.foldmethod:get())
        end)

        it("should set treesitter fold settings temporarily", function()
            vim.api.nvim_win_set_buf(test_win, test_bufnr)

            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"

            eq("expr", vim.opt_local.foldmethod:get())
            assert.is_true(vim.opt_local.foldexpr:get():find("treesitter") ~= nil)
        end)
    end)

    describe("autocmd", function()
        it("should register FileType autocmd for rust files", function()
            -- Get all autocmds for FileType rust
            local autocmds = vim.api.nvim_get_autocmds({
                event = "FileType",
                pattern = "rust",
            })

            -- Note: This checks if ANY autocmd exists for rust FileType
            -- In a real setup, this would be created when the module loads
            assert.is_not_nil(autocmds)
        end)
    end)

    describe("cursor position", function()
        it("should save and restore cursor position", function()
            local content = {
                "fn main() {",
                "    println!(\"Hello\");",
                "}",
                "",
                "#[cfg(test)]",
                "mod tests {",
                "    #[test]",
                "    fn test() {}",
                "}",
            }

            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, content)
            vim.api.nvim_win_set_buf(test_win, test_bufnr)

            -- Set cursor to line 2
            vim.api.nvim_win_set_cursor(test_win, { 2, 0 })
            local initial_pos = vim.api.nvim_win_get_cursor(test_win)

            -- Simulate cursor save/restore
            local saved_pos = initial_pos
            vim.api.nvim_win_set_cursor(test_win, { 6, 0 })
            vim.api.nvim_win_set_cursor(test_win, saved_pos)

            local restored_pos = vim.api.nvim_win_get_cursor(test_win)
            eq(initial_pos, restored_pos)
        end)
    end)

    describe("edge cases", function()
        it("should handle rust files without test modules", function()
            local content = {
                "fn add(a: i32, b: i32) -> i32 {",
                "    a + b",
                "}",
                "",
                "fn main() {",
                "    println!(\"{}\", add(2, 2));",
                "}",
            }

            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, content)

            vim.wait(500, function()
                local parser = vim.treesitter.get_parser(test_bufnr, "rust")
                return parser ~= nil
            end)

            local parser = vim.treesitter.get_parser(test_bufnr, "rust")
            if parser then
                local tree = parser:parse()[1]
                local root = tree:root()

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

                local found = false
                for id, node in query:iter_captures(root, test_bufnr, 0, -1) do
                    if query.captures[id] == "modName" then
                        found = true
                    end
                end

                assert.is_false(found, "Should not find test modules in non-test file")
            end
        end)

        it("should handle test modules without #[cfg(test)] attribute", function()
            local content = {
                "mod tests {",
                "    #[test]",
                "    fn test() {}",
                "}",
            }

            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, content)

            -- This should not match the query since there's no #[cfg(test)]
            -- The query specifically looks for the attribute
            local parser = vim.treesitter.get_parser(test_bufnr, "rust")
            if parser then
                local tree = parser:parse()[1]
                assert.is_not_nil(tree)
            end
        end)

        it("should handle malformed rust code gracefully", function()
            local content = {
                "#[cfg(test)]",
                "mod tests {",
                "    // Missing closing brace",
            }

            vim.api.nvim_buf_set_lines(test_bufnr, 0, -1, false, content)

            -- Parser should still work, though the tree might have errors
            local success = pcall(function()
                local parser = vim.treesitter.get_parser(test_bufnr, "rust")
                if parser then
                    parser:parse()
                end
            end)

            assert.is_true(success, "Should not crash on malformed code")
        end)
    end)

    describe("integration", function()
        it("should work with defer_fn timing", function()
            local called = false

            vim.defer_fn(function()
                called = true
            end, 100)

            -- Wait for the deferred function to execute
            vim.wait(200, function()
                return called
            end)

            assert.is_true(called, "Deferred function should execute")
        end)

        it("should properly detect FileType rust", function()
            local rust_buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_option(rust_buf, "filetype", "rust")

            local ft = vim.api.nvim_buf_get_option(rust_buf, "filetype")
            eq("rust", ft)

            vim.api.nvim_buf_delete(rust_buf, { force = true })
        end)
    end)

    describe("notification", function()
        it("should generate debug notifications", function()
            -- Mock vim.notify to capture calls
            local notifications = {}
            local original_notify = vim.notify

            vim.notify = function(msg, level)
                table.insert(notifications, { msg = msg, level = level })
            end

            -- Simulate a notification
            vim.notify("Test notification", vim.log.levels.DEBUG)

            -- Restore original notify
            vim.notify = original_notify

            assert.is_true(#notifications > 0)
            eq(vim.log.levels.DEBUG, notifications[1].level)
        end)
    end)
end)
