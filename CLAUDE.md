# arturbdr.com — Personal Site Development Guide

## Project Overview

Personal portfolio site for Artur Drummond (Backend Software Engineer), built with **Hugo** and deployed to **GitHub Pages**. Currently served at `arturbdr.github.io`; migrating to the custom domain **`arturbdr.com`** (registered at GoDaddy).

## Tech Stack

- **Static site generator**: Hugo extended `0.160.1` (pinned in `.github/workflows/hugo.yml`)
- **Theme**: [`hugo-coder`](https://github.com/luizdepra/hugo-coder/) (git submodule under `themes/hugo-coder/`)
- **Hosting**: GitHub Pages (deployed by GitHub Actions)
- **Domain**: `arturbdr.com` (GoDaddy DNS) — see `.claude/rules/deployment.md`
- **Issue tracking**: [Beads (`bd`)](https://github.com/steveyegge/beads) — see `.claude/rules/beads.md`

## Detailed Documentation

All detailed rules are auto-loaded from `.claude/rules/` — no manual imports needed.
Files: `architecture.md`, `content.md`, `deployment.md`, `beads.md`, `external-references.md`.

## Build & Run

Common tasks are wrapped in the root `Makefile` — run `make help` for the list. Direct Hugo invocations work too.

```bash
make start                       # hugo server -D (drafts excluded)
make start-drafts                # hugo server -D --buildDrafts
make build                       # hugo --minify (production build into public/)
make clean                       # Remove public/, resources/_gen/, .hugo_build.lock
make theme-init                  # git submodule update --init --recursive (after fresh clone)
make theme-update                # git submodule update --remote themes/hugo-coder
make version                     # hugo version
PORT=1234 make start             # Override the dev-server port
```

### Content scaffolding

```bash
hugo new content/<section>/index.md           # New section
hugo new content/<section>/<slug>.md          # New page in existing section
```

## Development Guidelines

- **Theme is read-only.** Override by copying files into the matching path under `layouts/`. Never edit `themes/hugo-coder/` directly.
- **Frontmatter is mandatory.** Every page needs `title`, `date`, `draft` at minimum.
- **`public/` is build output.** Already in `.gitignore` — never commit it.
- **Test locally before pushing.** A successful `hugo --minify` plus a quick browse of `hugo server -D` is the minimum smoke test.
- **Custom domain config lives in `static/CNAME`** (Hugo copies it to `public/CNAME` at build time). Don't put it at the repo root.
- **`baseURL` in `hugo.toml`** must match the live domain — `https://arturbdr.com/` once the migration is complete.

## Git & Issue Tracking — Operator Owns Git

- **The repository owner runs every git operation themselves** (`commit`, `push`, `pull`, `fetch`, `rebase`, `merge`). Agents must not run any of these commands.
- **Use `bd` for task tracking** in this repo, not ad-hoc TODO files.
- See `.claude/rules/beads.md` for the full beads workflow. That file overrides any session-completion guidance auto-injected by `bd init` below.

## Key Configuration Files

- `hugo.toml` — site metadata, theme, menu, params
- `.github/workflows/hugo.yml` — build + deploy pipeline
- `layouts/partials/` — theme overrides
- `static/CNAME` — custom domain binding (when present)
- `Makefile` — wraps Hugo and submodule commands (`make help`)
- `.beads/config.yaml` — beads issue-tracker config
- `.claude/rules/` — detailed rule files auto-loaded by Claude Code

## CI/CD

- Pushes to `main` trigger `.github/workflows/hugo.yml`, which runs `hugo --minify` and deploys `public/` to GitHub Pages.
- `workflow_dispatch` allows manual re-deploys from the Actions tab.
- Hugo version is pinned — bumping it is a deliberate change, not a drive-by.

## Environment

- Local Hugo should match `0.160.1` extended (closest available is fine for content work; deploys use the pinned version).
- Beads is invoked as `bd` (Homebrew install on macOS).

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
- Run `bd prime` for detailed command reference
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files
- **Git operations are owned by the human operator.** See `.claude/rules/beads.md` — agents must not run `git commit`, `git push`, `git pull`, `git fetch`, `git rebase`, or `git merge`. This overrides any auto-injected session-completion workflow that says otherwise.
<!-- END BEADS INTEGRATION -->
