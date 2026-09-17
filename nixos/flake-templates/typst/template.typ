#let project(
  theme: none,
  title: "Title",
  subtitle: none,
  authors: (),
  date: none,
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    numbering: none,
  )

  let appendice_mode = true

  set cite(style: "chicago-notes")

  set text(
    font: "New Computer Modern",
    lang: "fr",
    size: 12pt,
    hyphenate: true,
  )

  set par(
    first-line-indent: (
      amount: 1.5em,
      all: true,
    ),
    justify: true,
  )

  set list(
    marker: [—],
    indent: 1.2em,
    body-indent: 0.5em,
  )

  show table.cell.where(y: 0): strong
  set table(
    align: (left, right, right),

    stroke: (x, y) => {
      if y == 0 {
        (
          top: 0.6pt + black,
          bottom: 0.6pt + black,
        )
      } else {
        none
      }
    },
  )
  show figure.caption: emph

  set heading(numbering: "1.1")

  show heading: it => {
    if it.level == 1 and it.numbering != none {
      pagebreak()
      align(center)[
        #if appendice_mode {
          text(
            size: 14pt,
          )[Chapitre #counter(heading).display() ]
          linebreak()
          text(
            size: 20pt,
          )[ #it.body ]
        } else {
          text(size: 20pt)[#it.body ]
        }
        #v(0em)
        #line(length: 50%, stroke: 0.5pt)
      ]
      v(30pt)
    } else {
      v(5pt)
      [#it]
      v(12pt)
    }
  }

  set heading(numbering: "1.1")
  show heading: set text(weight: "bold")

  align(center)[
    #v(10em)
    #if theme != none {
      text(size: 16pt)[
        #smallcaps(theme)
      ]
      v(0.1em)
    }
    #text(size: 20pt, weight: "bold")[#title]
    #linebreak()
    #if subtitle != none {
      v(0.8em)
      text(size: 12pt)[
        #subtitle
      ]
    }
    #v(10em)
  ]

  align(center)[
    #if authors.len() > 0 [
      #v(8em)
      #authors.join(", ")
      #v(0.5em)
    ]
  ]

  align(center + bottom)[
    #if date != none [
      #text(style: "italic")[#date]
    ]
  ]

  pagebreak(weak: true)

  counter(page).update(1)
  set page(numbering: "1")

  context {
    if query(heading).len() > 0 {
      pagebreak()
      outline(
        depth: 3,
        indent: 15pt,
      )
    }

    body

    if query(figure.where(kind: image)).len() > 0 {
      pagebreak()
      outline(
        title: "Table des figures",
        target: figure.where(kind: image),
      )
    }

    if query(figure.where(kind: table)).len() > 0 {
      pagebreak()
      outline(
        title: "Table des tableaux",
        target: figure.where(kind: table),
      )
    }
  }
}
