# Quick Start: Testing in Neovim

Get up and running with tests in 5 minutes.

## Prerequisites

```bash
# Ensure you have Rust treesitter parser installed
nvim -c "TSInstall rust" -c "quitall!"
```

## Run Tests

```bash
# From the nvim directory
cd tests
./run_tests.sh
```

Or using make:

```bash
# From the nvim directory
make test
```

## Write Your First Test

Create a new test file: `tests/my_feature_spec.lua`

```lua
local eq = assert.are.same

describe("my feature", function()
  it("should work correctly", function()
    local result = 2 + 2
    eq(4, result)
  end)
end)
```

Run it:

```bash
nvim --headless -c "PlenaryBustedFile tests/my_feature_spec.lua" -c "quitall!"
```

## Testing the Rust Folding Utility

See the complete test suite: `tests/rust_test_folding_spec.lua`

Key patterns demonstrated:

### 1. Create a test buffer

```lua
local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_option(bufnr, "filetype", "rust")
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  "#[cfg(test)]",
  "mod tests {",
  "    #[test]",
  "    fn test_one() {}",
  "}",
})
```

### 2. Wait for treesitter

```lua
vim.wait(500, function()
  local parser = vim.treesitter.get_parser(bufnr, "rust")
  return parser ~= nil
end)
```

### 3. Query treesitter

```lua
local query = vim.treesitter.query.parse("rust", [[
  (attribute_item
    (attribute) @attr (#contains? @attr "test"))
]])

local parser = vim.treesitter.get_parser(bufnr, "rust")
local tree = parser:parse()[1]
local root = tree:root()

for id, node in query:iter_captures(root, bufnr, 0, -1) do
  if query.captures[id] == "attr" then
    -- Found a test attribute!
  end
end
```

### 4. Clean up

```lua
after_each(function()
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end)
```

## Using Test Helpers

The `test_helpers.lua` module provides utilities:

```lua
local helpers = require("tests.test_helpers")

-- Create a buffer with content
local bufnr = helpers.create_test_buffer({
  filetype = "rust",
  content = { "line 1", "line 2" }
})

-- Load a fixture
helpers.load_fixture_into_buffer(bufnr, "sample_rust_test.rs")

-- Wait for parser
helpers.wait_for_parser(bufnr, "rust", 1000)

-- Count query matches
local count = helpers.count_query_captures(bufnr, "rust", query_string, "attr")

-- Clean up
helpers.delete_buffer(bufnr)
```

## Common Assertions

```lua
-- Equality
assert.are.same(expected, actual)
assert.are.equal(expected, actual)

-- Boolean
assert.is_true(value)
assert.is_false(value)

-- Nil checks
assert.is_nil(value)
assert.is_not_nil(value)

-- Errors
assert.has_error(function() error("boom") end)
```

## Interactive Testing

Run tests interactively to debug:

```bash
nvim -u tests/minimal_init.lua tests/rust_test_folding_spec.lua
```

Then inside Neovim:

```vim
:PlenaryBustedFile %
```

## Watch Mode

Install `entr` and run:

```bash
make test-watch
```

This reruns tests automatically when files change.

## Next Steps

- Read `tests/README.md` for complete documentation
- Check `tests/example_test_spec.lua` for more patterns
- See `tests/test_helpers.lua` for all available utilities
- Review `tests/rust_test_folding_spec.lua` for a full test suite example

## Troubleshooting

**Parser not found?**
```bash
nvim -c "TSInstall rust" -c "quitall!"
```

**Tests timeout?**
Increase timeout in `tests/minimal_init.lua`:
```lua
vim.env.PLENARY_TEST_TIMEOUT = 20000
```

**Tests fail in CI?**
Use the headless command:
```bash
nvim --headless -c "PlenaryBustedDirectory tests/" -c "quitall!"
```

## Resources

- [Plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [TreeSitter Docs](https://tree-sitter.github.io/tree-sitter/)