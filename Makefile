# public-tools Makefile

.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -c

.DEFAULT_GOAL := help

INSTALL_DIR ?= ~/.local/bin
TOOLS = brew-python/brew-python ec2-search/ec2-search gh-search/gh-search \
        gdir/gdir git-update-branches/git-update-branches-in-dir

.PHONY: help
help: ## Show this help
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*##"; OFS = ""} \
		/^##@/ {printf "\n\033[1m%s\033[0m\n", substr($$0, 5)} \
		/^[a-zA-Z0-9_-]+:.*?##/ {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

################################################
##@ Setup
################################################

.PHONY: install
install: check-deps ## Install Python dependencies for tools
	@echo "Installing Python dependencies..."
	pip install tabulate requests
	@echo ""
	@echo "Dependencies installed. Run 'make link' to add tools to PATH."

.PHONY: install-dev
install-dev: install ## Install development dependencies (linting, pre-commit)
	@echo "Installing development dependencies..."
	pip install pre-commit
	pre-commit install
	@echo "Development environment ready."

.PHONY: uninstall
uninstall: ## Remove Python dependencies
	pip uninstall -y tabulate requests pre-commit 2>/dev/null || true
	@echo "Python dependencies removed."

.PHONY: check-deps
check-deps: ## Check for required CLI tools
	@echo "Checking CLI tools..."
	@missing=""
	@command -v git >/dev/null 2>&1 || missing="$$missing git"
	@command -v gh >/dev/null 2>&1 || missing="$$missing gh"
	@if [ -n "$$missing" ]; then \
		echo "Missing required tools:$$missing"; \
		echo "Install with: brew install$$missing"; \
		exit 1; \
	fi
	@command -v aws >/dev/null 2>&1 || echo "Note: aws CLI not found (needed for ec2-search)"
	@echo "Required tools found."

################################################
##@ Tools
################################################

.PHONY: link
link: ## Symlink tools to INSTALL_DIR (default: ~/.local/bin)
	@mkdir -p $(INSTALL_DIR)
	@for tool in $(TOOLS); do \
		name=$$(basename $$tool); \
		ln -sf $(CURDIR)/$$tool $(INSTALL_DIR)/$$name; \
		echo "Linked $$name -> $(INSTALL_DIR)/$$name"; \
	done
	@echo ""
	@echo "Ensure $(INSTALL_DIR) is in your PATH."

.PHONY: unlink
unlink: ## Remove tool symlinks from INSTALL_DIR
	@for tool in $(TOOLS); do \
		name=$$(basename $$tool); \
		rm -f $(INSTALL_DIR)/$$name; \
		echo "Removed $(INSTALL_DIR)/$$name"; \
	done

################################################
##@ Development
################################################

.PHONY: lint
lint: ## Run all linters (requires make install-dev)
	pre-commit run --all-files

.PHONY: clean
clean: ## Clean pre-commit cache and Python bytecode
	pre-commit clean 2>/dev/null || true
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@echo "Cleaned."
