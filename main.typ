#import "@preview/minimal-note:0.10.0": minimal-note
#import "@preview/cmarker:0.1.6"

#show: minimal-note.with(
  title: [Paper Title],
  author: [Your Name],
  date: datetime.today().display("[month repr:long], [year]"), 
)

= Introduction
#lorem(10)

+ The climate
  - Temperature
  - Precipitation
+ The topography
+ The geology

#lorem(20)

= Next first  header 
Some text. 

== Second Header 
Some text with bullet points.
#lorem(120)
- Bla
- Bla
  - Bla
  - Bla
  // - Some references to books @electronic and @harry
  - some references to books with reference from .bib file @Dai2025jun or @DeJalon1994MBS


= Next section header
#lorem(120)

== Next section subttile 
#lorem(120)


#include "some_content.typ"


#cmarker.render(read("some_markdown.md"))


// = Bibliographie from .yaml file
// #bibliography("bibliography.yaml",style: "springer-lecture-notes-in-computer-science")

= Bibliographie from .bib file 
#bibliography("bibliography.bib", style: "ieee")