// Cover page, measured against the one from the TUM LaTeX template.

#import "colors.typ": tum-colors
#import "fonts.typ": _fonts

// No date yet: leave a gap that can be filled in by hand.
#let _cover-date(date) = {
  if date == none { return box(width: 2.3cm) }
  assert(
    type(date) == datetime,
    message: "tum-dissertation: dates must be a datetime like `datetime(year: 2026, month: 10, day: 9)` or none, got " + repr(date) + ".",
  )
  date.display("[day].[month].[year]")
}

#let _cover(
  title: none,
  author: none,
  school: none,
  degree: none,
  chair: none,
  examiners: (),
  submission-date: none,
  acceptance-date: none,
) = page(
  margin: (left: 30mm, right: 30mm, top: 73.3mm, bottom: 20mm),
  header: none,
  footer: none,
  numbering: none,
  {
    set text(font: _fonts.sans, size: 12pt, lang: "de")
    set par(justify: false, leading: 0.5em, spacing: 0.5em, first-line-indent: 0pt)
    set block(spacing: 0.5em)

    place(top + left, dx: -5mm, dy: -59.45mm, text(
      font: _fonts.cover-header,
      size: 10pt,
      fill: tum-colors.primary-blue,
      par(leading: 0.47em)[#school \ Technische Universität München],
    ))
    place(
      top + right,
      dx: 20mm,
      dy: -63.3mm,
      image("assets/tum-logo-blue.svg", width: 19mm),
    )

    align(center, text(size: 17.28pt, weight: "bold", fill: tum-colors.primary-blue, title))
    v(8.5mm)
    align(center, text(size: 14.4pt, weight: "bold", author))

    v(1fr)

    [Vollständiger Abdruck der von der #school der Technischen Universität München zur Erlangung des akademischen Grades eines]
    v(5mm)
    align(center, text(size: 14.4pt, weight: "bold", degree))
    v(5.6mm)
    [genehmigten Dissertation.]

    v(12mm)
    [*Vorsitz:* #if chair != none [\ #chair]]
    v(7mm)
    [*Prüfer\*innen der Dissertation:*]
    pad(left: 8mm, enum(
      spacing: 0.5em,
      ..examiners.map(e => if e == none [] else [#e]),
    ))

    v(17mm)
    [Die Dissertation wurde am #_cover-date(submission-date) bei der Technischen Universität München eingereicht und durch die #school am #_cover-date(acceptance-date) angenommen.]

    v(22.85mm)
  },
)
