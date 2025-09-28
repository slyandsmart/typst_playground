#import "@preview/minimal-presentation:0.6.0": *

#set text(font: "Lato")
#show math.equation: set text(font: "Lato Math")
#show raw: set text(font: "Fira Code")

#show: project.with(
  title: "Minimalist presentation template",
  sub-title: "This is where your presentation begins",
  author: "Martin Siegfried Sereinig",
  date: datetime.today().display("[month repr:long], [year]"),
  index-title: "Contents",
  logo: image("images/logo.svg"),
  logo-light: image("images/logo_light.svg"),
  cover: image("images/image_31.jpg"),
  main-color: rgb("#E30512"),
  lang: "en",
)


// This is a comment and here begins a section in the presentation 
= This is a section

== This is a slide title

#lorem(10)

- #lorem(10)
  - #lorem(10)
  - #lorem(10)
  - #lorem(10)

== One column image

#figure(
  image("images/image_1.jpg", height: 10.5cm),
  caption: [An image],
) <image_label>

== Two columns image

#columns-content()[
  #figure(
    image("images/image_1.jpg", width: 100%),
    caption: [An image],
  ) <image_label_1>
][
  #figure(
    image("images/image_1.jpg", width: 100%),
    caption: [An image],
  ) <image_label_2>
]

== Two columns

#columns-content()[
  - #lorem(10)
  - #lorem(10)
  - referenz zur bibliography @harry
  - #lorem(10)
][
  #figure(
    image("images/image_31.jpg", width: 100%),
    caption: [An image],
  ) <image_label_3>
]

= This is a section

== This is a slide title

#lorem(10)

= This is a section

== This is a slide title

#lorem(10)

= This is a section

== This is a slide title

#lorem(10)

= This is a very v v v v v v v v v v v v v v v v v v v v  long section

== This is a very v v v v v v v v v v v v v v v v v v v v  long slide title

= sub-title test

== Slide title

#lorem(50)

=== Slide sub-title 1

#lorem(50)

=== Slide sub-title 2

#lorem(50)
#ref(<image_label_3>)



==Bibliographie
#bibliography("bibliography.yaml")