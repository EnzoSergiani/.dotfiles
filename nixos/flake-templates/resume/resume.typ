#import "@preview/fontawesome:0.6.2": fa-icon, fa-version

#let SIZE-NAME = 28pt
#let SIZE-SECTION-TITLE = 12pt
#let SIZE-ENTRY-TITLE = 10pt
#let SIZE-BODY = 9pt
#let SIZE-META = 9pt

#let RULE-STROKE = 0.5pt
#let GAP-SECTION = 0.0em
#let GAP-HEADER = 00.0em
#let GAP-BLOCK = 0.6em

#let resume(body) = {
  fa-version("6")
  set page(
    paper: "a4",
    margin: (x: 1cm, y: 1cm),
    numbering: none,
  )
  set text(
    font: "New Computer Modern",
    lang: "fr",
    size: SIZE-BODY,
    hyphenate: true,
  )
  set par(first-line-indent: 1.2em, justify: true, leading: 0.55em)
  body
}

#let ext-link(url, body) = link(url)[#body ]

#let labeled-item(label, value) = [
  #text(weight: "bold")[#label : ] #value
]

#let section-title(title) = {
  set par(first-line-indent: 0pt)
  set block(spacing: 1.0em)
  text(size: SIZE-SECTION-TITLE, weight: "bold")[#title]
  line(length: 100%, stroke: RULE-STROKE)
}

#let contact-line(icon, value, url: none) = grid(
  columns: (1em, auto),
  column-gutter: 0.4em,
  align: (center + horizon, left),

  box(
    width: 1em,
    height: 1em,
    align(center + horizon)[
      #icon
    ],
  ),

  text(size: SIZE-BODY)[
    #if url != none [
      #link(url)[#value]
    ] else [
      #value
    ]
  ],
)

#let contact-block(
  address: none,
  mail: none,
  linkedin: none,
  github: none,
  rootme: none,
) = {
  let rows = ()
  if address != none {
    rows.push(
      contact-line(
        fa-icon("location-dot", size: SIZE-BODY),
        address,
      ),
    )
  }
  if mail != none {
    rows.push(
      contact-line(
        fa-icon("envelope", size: SIZE-BODY),
        mail,
        url: "mailto:" + mail,
      ),
    )
  }
  if linkedin != none {
    rows.push(
      contact-line(
        fa-icon("linkedin", size: SIZE-BODY),
        linkedin,
        url: "https://linkedin.com/" + linkedin,
      ),
    )
  }
  if github != none {
    rows.push(
      contact-line(
        fa-icon("github", size: SIZE-BODY),
        github,
        url: "https://github.com/" + github,
      ),
    )
  }
  if rootme != none {
    rows.push(
      contact-line(
        move(dy: -0.14em)[
          #image("figure/root-me.png", width: 1em)
        ],
        rootme,
        url: "https://www.root-me.org/" + rootme,
      ),
    )
  }
  stack(
    dir: ttb,
    spacing: 0.5em,
    ..rows,
  )
}

#let profil(
  name: none,
  job: none,
  subject: none,
  address: none,
  mail: none,
  linkedin: none,
  github: none,
  rootme: none,
) = {
  grid(
    columns: (2cm, 11.5cm, 1fr),
    gutter: 1em,

    image("figure/profil.png", width: 2cm),

    block(
      height: 2.2cm,
    )[
      #stack(
        dir: ttb,

        text(size: SIZE-NAME, weight: "bold")[#name],

        v(1fr),

        if subject != none and subject != "" [
          #text(size: 12pt)[#job]
          #linebreak()
          #text(size: 12pt)[#subject]
          #v(1em)
        ] else [
          #text(size: 16pt)[#job]
          #v(1.2em)
        ],
      )
    ],

    align(left + top)[
      #contact-block(
        address: address,
        mail: mail,
        linkedin: linkedin,
        github: github,
        rootme: rootme,
      )
    ],
  )
}

#let about(description: none) = {
  section-title("Profil")
  text(size: SIZE-BODY)[#description]
  v(GAP-BLOCK)
}

#let entry(
  title: none,
  subtitle: none,
  location: none,
  date: none,
  logo: none,
  body: none,
) = {
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [
      #text(size: SIZE-ENTRY-TITLE, weight: "bold")[#title]
      #if subtitle != none [
        #linebreak()
        #text(size: SIZE-META, style: "italic")[#subtitle]
      ]
    ],
    [
      #if location != none [
        #text(size: SIZE-META, weight: "bold")[#location]
        #linebreak()
      ]
      #if date != none [
        #text(size: SIZE-META, style: "italic")[#date]
      ]
    ],
  )
  v(GAP-HEADER)
  set text(size: SIZE-BODY)
  if logo != none {
    grid(
      columns: (2cm, 1fr),
      column-gutter: 0.8em,
      align: (center + horizon, left),
      image(logo, width: 1.2cm), body,
    )
  } else {
    pad(left: 1em)[#body]
  }
}

#let section(title: none, ..entries) = {
  section-title(title)
  for e in entries.pos() {
    v(GAP-SECTION)
    e
    v(GAP-SECTION)
  }
  v(GAP-BLOCK)
}

#let certifications(title: "Certifications", ..items) = {
  section-title(title)
  set text(size: SIZE-BODY)
  list(..items.pos().map(c => ext-link(c.url, c.label)))
  v(GAP-BLOCK)
}

#let labeled-section(title: none, ..fields) = {
  section-title(title)
  set text(size: SIZE-BODY)
  list(..fields.pos().map(f => labeled-item(f.label, f.value)))
  v(GAP-BLOCK)
}

#let skills(..fields) = labeled-section(title: "Compétences", ..fields)

#let interests(..fields) = labeled-section(
  title: "Centres d'intérêt",
  ..fields,
)
