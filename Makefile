.DEFAULT_GOAL := help

HUGO ?= hugo
PORT ?= 1313

.PHONY: help install clean clean-all start start-drafts start-fast build version kill

help: ## Show this help (default target)
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install npm dependencies (Toha runtime assets)
	npm install --silent

clean: ## Remove Hugo build outputs and asset cache (public/, resources/_gen, locks, stats)
	rm -rf public/ resources/_gen/ .hugo_build.lock hugo_stats.json .cache/ tmp/

clean-all: clean ## Also remove node_modules (forces a full npm reinstall on next install)
	rm -rf node_modules

kill: ## Stop any running hugo server processes (use if a dev server got stuck)
	@pkill -f 'hugo server' && echo "  ✓ killed running hugo server(s)" || echo "  no hugo server running"

start: kill clean install ## Run dev server with a fresh cache (default — slower start, no stale state)
	$(HUGO) server -D --gc -p $(PORT)

start-drafts: kill clean install ## Run dev server with drafts and a fresh cache
	$(HUGO) server -D --gc --buildDrafts -p $(PORT)

start-fast: install ## Run dev server WITHOUT clearing cache (faster, but can serve stale assets)
	$(HUGO) server -D -p $(PORT)

build: clean install ## Production build into public/ (clean + minified)
	$(HUGO) --minify --gc

version: ## Print local Hugo version
	$(HUGO) version
