#let letter(
  source-name: none,
  source-address: none,
  source-postal-code: none,
  source-city: none,
  source-country: none,
  source-email: none,
  source-phone: none,
  recipient-name: none,
  recipient-address: none,
  recipient-postal-code: none,
  recipient-city: none,
  recipient-country: none,
  subject: none,
  body,
) = {
  let has-value(value) = value != none and value != ""

  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: none,
  )

  set text(
    font: "New Computer Modern",
    lang: "fr",
    size: 12pt,
    hyphenate: true,
  )

  set par(
    justify: true,
    first-line-indent: 0pt,
    leading: 0.4em,
  )

  let signature() = {
    v(1em)

    text(
      "Je vous prie d’agréer, Madame, Monsieur, l’expression de mes salutations distinguées.",
    )

    v(1em)

    grid(
      columns: (1fr, 1fr),
      [#source-name],
      [
        #move(
          dx: 3.5cm,
          dy: 0.5cm,
          image("figure/signature.png", width: 3cm),
        )
      ],
    )
  }

  align(left)[
    #stack(
      spacing: 0.30em,

      if has-value(source-name) [
        #source-name
      ],

      if has-value(source-address) [
        #source-address
      ],

      if has-value(source-postal-code) or has-value(source-city) [
        #if has-value(source-postal-code) and has-value(source-city) {
          source-postal-code
          [,]
          h(0.25em)
          source-city
        } else if has-value(source-postal-code) {
          source-postal-code
        } else {
          source-city
        }
      ],

      if has-value(source-country) [
        #source-country
      ],

      if has-value(source-email) [
        #source-email
      ],

      if has-value(source-phone) [
        #source-phone
      ],
    )
  ]

  align(right)[
    #stack(
      spacing: 0.30em,

      [À l'attention de :],

      if has-value(recipient-name) [
        #recipient-name
      ],

      if has-value(recipient-address) [
        #recipient-address
      ],

      if has-value(recipient-postal-code) or has-value(recipient-city) [
        #if has-value(recipient-postal-code) and has-value(recipient-city) {
          recipient-postal-code
          [, ]
          recipient-city
        } else if has-value(recipient-postal-code) {
          recipient-postal-code
        } else {
          recipient-city
        }
      ],

      if has-value(recipient-country) [
        #recipient-country
      ],

      v(1em),

      let french-weekdays = (
        "lundi",
        "mardi",
        "mercredi",
        "jeudi",
        "vendredi",
        "samedi",
        "dimanche",
      ),

      let french-months = (
        "janvier",
        "février",
        "mars",
        "avril",
        "mai",
        "juin",
        "juillet",
        "août",
        "septembre",
        "octobre",
        "novembre",
        "décembre",
      ),

      let french-date(date) = {
        french-weekdays.at(date.weekday() - 1)
        " "
        str(date.day())
        " "
        french-months.at(date.month() - 1)
        " "
        str(date.year())
      },

      let today = datetime.today(),

      [
        #if has-value(source-city) {
          [Fait à #source-city, le #french-date(today).]
        } else {
          [Fait le #french-date(today).]
        }
      ],
    )
  ]

  if subject != none {
    v(1em)

    strong[Objet : ]
    subject
    text(".")
  }

  v(1em)

  body

  v(1em)

  signature()
}
