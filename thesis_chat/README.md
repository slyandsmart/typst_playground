
# Typst Thesis Template (UMIT TIROL style)

## Quick Start
```bash
typst compile main.typ build/thesis.pdf
```

- Edit `settings.typ` (metadata, layout).
- Write content in `frontmatter/*.typ` and `chapters/*.typ`.
- Add references to `refs.bib` or change the CSL file in `print-bibliography()`.

## Structure
- `main.typ` — entry point, includes front matter, TOC, lists, chapters, bibliography, declaration.
- `settings.typ` — all configuration & reusable functions (title page, lists, etc.).
- `frontmatter/` — introduction, acknowledgments, abstracts (as separate files if preferred).
- `chapters/` — your chapters as individual `.typ` files.
- `figures/` and `tables/` — assets.
- `refs.bib` — BibTeX database; `ieee-with-url.csl` is a minimal IEEE-like CSL (replace as needed).

## Notes
- Two-sided layout via `inside/outside` margins.
- Title page, supervisor/evaluator page, Kurzfassung, Abstract match the sequence in the faculty example.
- The last page includes the German "Verpflichtungs- und Einverständniserklärung".
