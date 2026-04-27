# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal portfolio website built with Hugo static site generator, deployed to GitHub Pages. The site showcases professional experience, projects, and contact information for Artur Drummond, a Backend Software Engineer.

## Architecture

### Hugo Site Structure

- **Theme**: Uses `hugo-coder` theme as a Git submodule (located in `themes/hugo-coder/`)
- **Configuration**: `hugo.toml` contains site-wide settings including:
  - Base URL: https://arturbdr.github.io/
  - Theme: hugo-coder with dark color scheme
  - Menu structure (About, Experience, Projects, Contact)
  - Social links (GitHub, LinkedIn)

### Content Organization

Content is organized in section-based directories under `content/`:
- `content/about/` - Professional background and technical expertise
- `content/experience/` - Work history
- `content/projects/` - Portfolio projects
- `content/contact/` - Contact information

Each section contains an `index.md` file with frontmatter (title, date, draft status) and markdown content.

### Customization

- **Layouts**: Custom layout overrides are placed in `layouts/partials/`
  - Currently customized: `footer.html` (displays copyright with current year)
- Theme defaults can be overridden by creating files in `layouts/` that mirror the theme structure

### Deployment

- **CI/CD**: GitHub Actions workflow (`.github/workflows/hugo.yml`)
  - Triggers on push to `main` branch or manual workflow dispatch
  - Uses Hugo version 0.139.3 (extended version)
  - Builds with `hugo --minify` command
  - Deploys to GitHub Pages automatically
  - Build artifacts are placed in `public/` directory (git-ignored)

## Development Commands

### Local Development

```bash
# Start local development server with live reload
hugo server -D

# Start server and include draft content
hugo server -D --buildDrafts

# Start server on specific port
hugo server -D -p 1313
```

### Building

```bash
# Build site for production (outputs to public/)
hugo --minify

# Build without minification
hugo

# Clean build artifacts
rm -rf public/
```

### Content Management

```bash
# Create new content section
hugo new content/section-name/index.md

# Create new page in existing section
hugo new content/section-name/page-name.md
```

### Theme Management

The hugo-coder theme is managed as a Git submodule:

```bash
# Initialize submodules (after fresh clone)
git submodule update --init --recursive

# Update theme to latest version
git submodule update --remote themes/hugo-coder

# Check submodule status
git submodule status
```

## Key Configuration Files

- `hugo.toml` - Main site configuration (site metadata, theme, menu, params)
- `.github/workflows/hugo.yml` - Automated deployment pipeline
- `layouts/partials/` - Custom layout overrides for the theme

## Development Workflow

1. Content changes go in `content/` directories as markdown files
2. Theme customizations go in `layouts/` (mirrors theme structure)
3. Test locally with `hugo server -D`
4. Commit changes to `main` branch
5. GitHub Actions automatically builds and deploys to GitHub Pages
6. Site is live at https://arturbdr.github.io/

## Important Notes

- The `public/` directory is auto-generated and should not be committed
- Theme files should not be modified directly; use layout overrides instead
- All content uses frontmatter (YAML) with required fields: title, date, draft
- Hugo extended version is required (specified in GitHub Actions: 0.139.3)


<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:ca08a54f -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

## Session Completion

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd dolt push
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
<!-- END BEADS INTEGRATION -->
