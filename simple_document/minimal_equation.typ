// #import "@preview/mitex:0.2.5": *
// //https://typst.app/universe/package/mitex/ also as cli tool possible 
// #set page(fill: none)

// #let thing(body) = context {
//   let size = measure(body)
//   [Width of "#body" is #size.width]
// }

// #thing[
// $ F = m dot a $
// $ alpha = sin(gamma)$
// ]

// $ F = m dot a $


// #mitex(`
//   \newcommand{\f}[2]{#1f(#2)}
//   \f\relax{x} = \int_{-\infty}^\infty
//     \f\hat\xi\,e^{2 \pi i \xi x}
//     \,d\xi
// `)


// $ alpha = sin(gamma)$
// #mitex(`
// \alpha = \sin(\gamma)
// `)

#let text = lorem(30)
#layout(size => [
  #let (height,) = measure(
    block(width: size.width, text),
  )
  This text is #height high with
  the current page width: \
  #text
])

#set page(width: 5cm, height: 6cm)