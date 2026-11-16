# Technical Writing Portfolio Site

[![Prose lint (Vale)](https://github.com/MackMike/technical-writing-portfolio-site/actions/workflows/vale.yml/badge.svg)](https://github.com/MackMike/technical-writing-portfolio-site/actions/workflows/vale.yml)

This repository contains the source files, assets, and supporting materials for my hosted technical writing portfolio site. It is used for site maintenance, content organization, and publishing.

## Portfolio Access

If you are looking for my portfolio content, please visit:

- [Live Portfolio Site](https://mackmike.github.io/technical-writing-portfolio-site/)
- [Technical Writing Portfolio Repository](https://github.com/MackMike/michael-scarborough-technical-writing-portfolio)
- [GitHub Profile](https://github.com/MackMike)

## Prose linting with Vale

The Markdown pages in this repository are checked with [Vale](https://vale.sh/), a prose linter, using the Google developer documentation style guide as the base.

- **Config:** `.vale.ini` in the repository root
- **Style guide:** Google, downloaded with `vale sync` into `.vale/styles/`
- **Vocabulary:** product names and terms that Vale should accept are listed in `.vale/styles/config/vocabularies/Portfolio/accept.txt`
- **Automation:** a GitHub Action (`.github/workflows/vale.yml`) runs Vale on every push and pull request and reports results on the Checks tab. It is report-only and never blocks a change.

### Choices I made

- **Scope:** only `docs/*.md` and `docs/projects/*.md` are linted. Generated output, such as the DITA HTML, is excluded.
- **Alert level:** warnings and errors only, to keep the signal useful.
- **Rules turned off:** I turned off the Google rules for sentence-case headings, lowercase after colons, first-person pronouns, word-list substitutions, and spaced em dashes. The portfolio pages use title case, first person, and a macOS and developer vocabulary on purpose, so these rules mostly produce noise.

### Run it locally

```bash
brew install vale
vale sync
vale docs/projects docs/index.md docs/about.md docs/resume.md
```

## Build the DITA sample output

The DITA sample in `docs/assets/pdfs/dita/managed-mac-onboarding/` is published as HTML5 with the DITA Open Toolkit. Rebuild it before building the site:

```bash
brew install dita-ot
scripts/build-dita-onboarding.sh
mkdocs build
```

The stylesheet is in `scripts/dita-style/portfolio.css`.

## Note

This repository supports the hosted portfolio site and is not intended to serve as the primary overview of the portfolio.
