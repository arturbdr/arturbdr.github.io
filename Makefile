.DEFAULT_GOAL := help

HUGO ?= hugo
PORT ?= 1313

.PHONY: help install start start-drafts build clean version

help: ## Show this help (default target)
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install npm dependencies (Toha runtime assets)
	npm install

start: install ## Run Hugo dev server with live reload (drafts excluded)
	$(HUGO) server -D -p $(PORT)

start-drafts: install ## Run Hugo dev server including draft content
	$(HUGO) server -D --buildDrafts -p $(PORT)

build: install ## Production build into public/ (minified)
	$(HUGO) --minify

clean: ## Remove build artifacts (public/, resources/_gen/, .hugo_build.lock)
	rm -rf public/ resources/_gen/ .hugo_build.lock

version: ## Print local Hugo version
	$(HUGO) version
