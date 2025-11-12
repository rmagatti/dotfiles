# Neovim Configuration Tests

This directory contains unit tests for custom Neovim utilities using [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)'s test framework.

## Prerequisites

- Neovim >= 0.9.0
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) (installed via your plugin manager)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) with Rust parser
- Rust treesitter parser: `:TSInstall rust`

## Directory Structure

```
tests/
├── README.md                      # This file
├── minimal_init.lua               # Minimal config for testing
├── run_tests.sh                   # Shell script to run all tests
├── rust_test_folding_spec.lua     # Tests for rust-test-folding utility
└── fixtures/
    └── sample_rust_test.rs        # Sample Rust file for testing
```

## Running Tests

### Option 1: Using the Shell Script (Recommended)

```bash
cd tests
chmod +x run_tests.sh
./run_tests.sh
```

### Option 2: Using Neovim Directly

From within Neovim:

```vim
:PlenaryBustedDirectory tests/
```

Or for a specific test file:

```vim
:PlenaryBustedFile tests/rust_test_folding_spec.lua
```

### Option 3: Command Line

```bash
nvim --headless -c "PlenaryBustedDirectory tests/" -c "quitall!"
```

### Option 4: Using Makefile (if you create one)

```bash
make test
```

## Test Coverage

### `rust_test_folding_spec.lua`

Tests for the `rust-test-folding.lua` utility that automatically folds Rust test modules.

**Test Suites:**

- ✓ **fold_rust_tests_cfg**: Core folding functionality
  - Identifies test modules with `#[cfg(test)]` attribute
  - Handles missing parsers gracefully
  - Works with empty files

- ✓ **treesitter query**: TreeSitter query validation
  - Validates query syntax
  - Finds multiple test modules
  - Matches correct AST patterns

- ✓ **fold settings**: Fold configuration management
  - Preserves original fold settings
  - Sets TreeSitter fold settings temporarily
  - Restores user settings after folding

- ✓ **autocmd**: Autocommand registration
  - Registers FileType autocmd for Rust files
  - Triggers on buffer load

- ✓ **cursor position**: Cursor management
  - Saves cursor position before folding
  - Restores cursor position after folding

- ✓ **edge cases**: Robustness testing
  - Handles files without test modules
  - Works with test modules without `#[cfg(test)]`
  - Handles malformed Rust code gracefully

- ✓ **integration**: End-to-end testing
  - Tests `defer_fn` timing
  - Validates FileType detection

- ✓ **notification**: Debug output
  - Verifies debug notifications are generated

## Writing New Tests

### Test File Naming Convention

Test files should follow the pattern: `<module_name>_spec.lua`

Example:
- `rust_test_folding_spec.lua` tests `rmagatti/rust-test-folding.lua`
- `my_utility_spec.lua` would test `rmagatti/my-utility.lua`

### Basic Test Structure

```lua
local eq = assert.are.same

describe("my_module", function()
  before_each(function()
    -- Setup before each test
  end)

  after_each(function()
    -- Cleanup after each test
  end)

  describe("feature_name", function()
    it("should do something specific", function()
      -- Arrange
      local input = "test"
      
      -- Act
      local result = my_function(input)
      
      -- Assert
      eq("expected", result)
    end)
  end)
end)
```

### Useful Plenary Assertions

```lua
-- Equality
assert.are.same(expected, actual)
assert.are.equal(expected, actual)

-- Truthy/Falsy
assert.is_true(value)
assert.is_false(value)
assert.is_nil(value)
assert.is_not_nil(value)

-- Errors
assert.has_error(function() error("boom") end)
assert.has_no_errors(function() -- code end)

-- Tables
assert.are.same({ 1, 2, 3 }, result)
```

### Testing with Buffers

```lua
it("should work with buffers", function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(bufnr, "filetype", "rust")
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "line 1", "line 2" })
  
  -- Your test code here
  
  vim.api.nvim_buf_delete(bufnr, { force = true })
end)
```

### Waiting for Async Operations

```lua
it("should wait for async operations", function()
  local done = false
  
  vim.defer_fn(function()
    done = true
  end, 100)
  
  vim.wait(200, function()
    return done
  end)
  
  assert.is_true(done)
end)
```

### Creating Test Fixtures

Place test fixtures in the `fixtures/` directory:

```
fixtures/
├── sample_rust_test.rs      # Rust test file
├── sample_config.lua         # Lua config file
└── sample_data.json          # JSON data
```

Load fixtures in tests:

```lua
local fixture_path = vim.fn.expand("tests/fixtures/sample_rust_test.rs")
local content = vim.fn.readfile(fixture_path)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
```

## Best Practices

1. **Isolation**: Each test should be independent and not rely on other tests
2. **Cleanup**: Always clean up resources (buffers, windows, autocommands) in `after_each`
3. **Descriptive Names**: Use clear, descriptive test names that explain what is being tested
4. **Arrange-Act-Assert**: Structure tests with clear setup, execution, and verification phases
5. **Test One Thing**: Each test should verify one specific behavior
6. **Mock External Dependencies**: Use mocks for external dependencies when appropriate
7. **Edge Cases**: Test edge cases, error conditions, and boundary values

## Debugging Tests

### Run Tests with Verbose Output

```bash
PLENARY_TEST_VERBOSE=1 nvim --headless -c "PlenaryBustedDirectory tests/" -c "quitall!"
```

### Run a Single Test

```vim
:PlenaryBustedFile tests/rust_test_folding_spec.lua
```

### Add Debug Output

```lua
it("should debug something", function()
  print("Debug value:", vim.inspect(my_value))
  -- Your test code
end)
```

## Continuous Integration

To run tests in CI (GitHub Actions, GitLab CI, etc.):

```yaml
- name: Run Neovim tests
  run: |
    cd nvim/tests
    chmod +x run_tests.sh
    ./run_tests.sh
```

## References

- [Plenary.nvim Documentation](https://github.com/nvim-lua/plenary.nvim)
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [Neovim API Documentation](https://neovim.io/doc/user/api.html)
- [TreeSitter Documentation](https://tree-sitter.github.io/tree-sitter/)
- [Busted Test Framework](https://lunarmodules.github.io/busted/) (plenary uses busted-style assertions)

## Contributing

When adding new utilities to the Neovim configuration:

1. Write tests first (TDD) or immediately after implementation
2. Ensure all tests pass before committing
3. Add integration tests for complex features
4. Document any special test requirements in this README

## Troubleshooting

### "Parser not found" errors

Install the required TreeSitter parser:

```vim
:TSInstall rust
```

### Tests timeout

Increase the timeout in `minimal_init.lua`:

```lua
vim.env.PLENARY_TEST_TIMEOUT = 20000
```

### Tests fail in headless mode but pass in UI

Some features behave differently in headless mode. Test with:

```bash
nvim -u tests/minimal_init.lua tests/rust_test_folding_spec.lua
```

Then run `:PlenaryBustedFile %` to debug interactively.