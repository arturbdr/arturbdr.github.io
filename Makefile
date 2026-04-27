.DEFAULT_GOAL := help

HUGO ?= hugo
PORT ?= 1313

.PHONY: help start start-drafts build clean theme-init theme-update version

help: ## Show this help (default target)
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: ## Run Hugo dev server with live reload (drafts excluded)
	$(HUGO) server -D -p $(PORT)

start-drafts: ## Run Hugo dev server including draft content
	$(HUGO) server -D --buildDrafts -p $(PORT)

build: ## Production build into public/ (minified)
	$(HUGO) --minify

clean: ## Remove build artifacts (public/, resources/_gen/, .hugo_build.lock)
	rm -rf public/ resources/_gen/ .hugo_build.lock

theme-init: ## Initialise git submodules (run after a fresh clone)
	git submodule update --init --recursive

theme-update: ## Update the hugo-coder theme submodule to its latest commit
	git submodule update --remote themes/hugo-coder

version: ## Print local Hugo version
	$(HUGO) version
