
// settings.typ — central configuration & reusable components for the thesis
#let meta = (
  uni: "UMIT TIROL",
  department: "Department für Biomedizinische Informatik und Mechatronik",
  thesis_type: "Masterarbeit",
  study_program: "Mechatronik",
  city: "Hall in Tirol",
  date: datetime.today().display("[month repr:long], [year]"), 
  title: [
    The Title of my Thesis Plus Some Text to
    Exceed a Single Line and Maybe Even Long
    Enough to Produce Three Lines (but not More!)
  ],
  subtitle: [Template for preparing Master Theses in Mechatronics at UMIT TIROL],
  author: "Bettina Mayer, BSc",
  evaluator: (
    name: "Univ.-Prof. Dr. Frank Woittennek",
    affiliation: "Institut für Automatisierungs- und Regelungstechnik"
  ),
  supervisor: (
    name: "Univ.-Prof. Dr. Frank Woittennek, Universität Innsbruck",
    affiliation: "Institut für Automatisierungs- und Regelungstechnik"
  ),
  cosupervisor: (
    name: "Univ.-Prof. Dr. Manfred Husty, Universität Innsbruck",
    affiliation: "Institut für Grundlagen der Technischen Wissenschaften, Arbeitsbereich für Geometrie und CAD"
  ),
  language: "english",
)

#set page(paper: "a4", margin: (inside: 30mm, outside: 20mm, top: 20mm, bottom: 25mm), numbering: "1")
#set par(justify: true, leading: 1.2em)
#set text(font: "Libertinus Serif", size: 11pt)
#set heading(numbering: "1.1.1")

#let header-content() = context {
  let left = locate(loc => if loc.page.even { counter(heading).display() } else { text(meta.author) })
  let right = locate(loc => if loc.page.even { text(meta.author) } else { counter(heading).display() })
  grid(columns: (1fr, 1fr), [#left], align(left, right), stroke: none)
}

#let footer-content() = context { align(center)[#page()] }

#show: page.with(
      header: header-content(), 
      footer: footer-content())

#let chapter(title, short: none, body) = { heading(level: 1, numbering: none, title); body }






#let titlepage() = {
  pagebreak(weak: true)
  v(1fr)
  align(center)[
    strong(meta.department) \
    \
    text(size: 18pt, weight: "bold")[#meta.title] \
    if meta.subtitle != none { text(size: 12pt)[#meta.subtitle] } \
    \
    text(size: 12pt)[#meta.author] \
    text(size: 11pt)[#meta.city, ", ", datetime.display(meta.date, "MMMM d, yyyy")] \
    \
    text(size: 12pt, weight: "bold")[#meta.thesis_type] \
    \
    text(size: 10pt)[verfasst im Rahmen eines gemeinsamen Masterstudienprogramms von LFUI und UMIT TIROL - Joint Degree Programme] \
    text(size: 10pt)[eingereicht an der UMIT TIROL - Privatuniversität für Gesundheitswissenschaften und -technologie, Department für Biomedizinische Informatik und Mechatronik zur Erlangung des akademischen Grades] \
    text(size: 12pt, weight: "bold")[Diplomingenieurin] \
    }
  ]
  v(1fr)
  pagebreak()
  block(spacing: 0.75em)[
    strong[Beurteilerin:] \
    [#meta.evaluator.name] \
    [#meta.evaluator.affiliation]
    \
    strong[Betreuerin:] \
    [#meta.supervisor.name] \
    [#meta.supervisor.affiliation]
    \
    if meta.cosupervisor != none {
      strong[Mitbetreuer:] \
      [#meta.cosupervisor.name] \
      [#meta.cosupervisor.affiliation]
    }
  ]
  pagebreak()
}

#let acknowledgment(text: none) = {
  if text != none { heading(level: 1, numbering: none)[Acknowledgment]; text; pagebreak() }
}

#let kurzfassung(text) = { heading(level: 1, numbering: none)[Kurzfassung]; text; pagebreak() }
#let abstract(text) = { heading(level: 1, numbering: none)[Abstract]; text; pagebreak() }

#let declaration() = {
  pagebreak()
  heading(level: 1, numbering: none)[Verpflichtungs- und Einverständniserklärung]
  par[Ich erkläre hiermit an Eides statt durch meine eigenhändige Unterschrift, dass ich die vorliegende Arbeit selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe. Alle Stellen, die wörtlich oder inhaltlich den angegebenen Quellen entnommen wurden, sind als solche kenntlich gemacht.]
  par[Die vorliegende Arbeit wurde bisher in gleicher oder ähnlicher Form noch nicht als wissenschaftliche Arbeit eingereicht.]
  v(1fr)
  grid(columns: (1fr, 1fr))[ [#meta.city, " am ..............................."] [#meta.author] ]
}

#let print-bibliography(style: "ieee-with-url.csl") = {
  heading(level: 1, numbering: none)[Bibliography]
  bibliography("refs.bib", style: style)
}
