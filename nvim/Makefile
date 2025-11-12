.PHONY: help test test-file test-verbose install-deps clean

# Default target
.DEFAULT_GOAL := help

# Colors for output
YELLOW := \033[1;33m
GREEN := \033[0;32m
RED := \033[0;31m
NC := \033[0m # No Color

help: ## Show this help message
	@echo "$(YELLOW)Available targets:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

test: ## Run all tests
	@echo "$(YELLOW)Running all tests...$(NC)"
	@cd tests && ./run_tests.sh

test-file: ## Run a specific test file (use FILE=path/to/test_spec.lua)
	@if [ -z "$(FILE)" ]; then \
		echo "$(RED)Error: Please specify FILE=path/to/test_spec.lua$(NC)"; \
		exit 1; \
	fi
	@echo "$(YELLOW)Running test file: $(FILE)$(NC)"
	@nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile $(FILE)" -c "quitall!"

test-verbose: ## Run tests with verbose output
	@echo "$(YELLOW)Running tests with verbose output...$(NC)"
	@PLENARY_TEST_VERBOSE=1 nvim --headless -u init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = 'tests/minimal_init.lua' }" -c "quitall!"

test-interactive: ## Open Neovim to run tests interactively
	@echo "$(YELLOW)Opening Neovim for interactive testing...$(NC)"
	@echo "Run :PlenaryBustedDirectory tests/ to execute tests"
	@nvim -u tests/minimal_init.lua

install-deps: ## Install test dependencies (plenary, treesitter)
	@echo "$(YELLOW)Installing test dependencies...$(NC)"
	@nvim --headless -c "lua require('lazy').sync()" -c "quitall!" 2>/dev/null || echo "$(RED)Note: Run this from a configured Neovim instance$(NC)"
	@echo "$(GREEN)Installing Rust TreeSitter parser...$(NC)"
	@nvim --headless -c "TSInstall rust" -c "quitall!" 2>/dev/null || echo "$(YELLOW)Note: Install rust parser manually with :TSInstall rust$(NC)"

test-watch: ## Watch for changes and run tests (requires entr)
	@if ! command -v entr >/dev/null 2>&1; then \
		echo "$(RED)Error: entr is not installed. Install with: brew install entr (macOS) or apt-get install entr (Linux)$(NC)"; \
		exit 1; \
	fi
	@echo "$(YELLOW)Watching for changes in lua/ and tests/ directories...$(NC)"
	@echo "$(YELLOW)Press Ctrl+C to stop$(NC)"
	@find lua tests -name "*.lua" | entr -c make test

clean: ## Clean up test artifacts
	@echo "$(YELLOW)Cleaning up test artifacts...$(NC)"
	@find . -name "*.log" -type f -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Cleaned$(NC)"

lint: ## Run stylua formatter check
	@if command -v stylua >/dev/null 2>&1; then \
		echo "$(YELLOW)Checking Lua formatting with stylua...$(NC)"; \
		stylua --check lua/ tests/; \
	else \
		echo "$(RED)stylua not found. Install with: cargo install stylua$(NC)"; \
		exit 1; \
	fi

format: ## Format Lua files with stylua
	@if command -v stylua >/dev/null 2>&1; then \
		echo "$(YELLOW)Formatting Lua files with stylua...$(NC)"; \
		stylua lua/ tests/; \
		echo "$(GREEN)✓ Formatted$(NC)"; \
	else \
		echo "$(RED)stylua not found. Install with: cargo install stylua$(NC)"; \
		exit 1; \
	fi

check: lint test ## Run linter and tests
	@echo "$(GREEN)✓ All checks passed$(NC)"
