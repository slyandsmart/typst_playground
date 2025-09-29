#import "../settings.typ": *

#chapter("Information on this Class",[
== Goals
- Two-sided layout suitable for printing.
- German-first title page with English/German abstracts.
- Separate files for chapters and front matter.
- Figure/table lists generated from document content.
- Pluggable bibliography using CSL styles.

== Usage
- Edit `settings.typ` to set metadata.
- Write content in `frontmatter/*.typ` and `chapters/*.typ`.
- Add references to `refs.bib` (BibTeX).
])
