// TUM dissertation template. Only the cover follows the official TUM layout,
// everything else is up to you.

#import "colors.typ": tum-colors
#import "fonts.typ": _fonts
#import "cover.typ": _cover
#import "page.typ": _chapter-break, _is-chapter-start, _running-header, _top-margin
#import "frontmatter.typ": _frontmatter

/// Styles a document as a TUM dissertation: cover page, front matter, chapters
/// and bibliography.
///
/// Use it as a show rule at the top of the document:
/// ```typ
/// #show: dissertation.with(title: [My research], author: "Erika Mustermann")
/// ```
///
/// - title (content): Shown on the cover and in the PDF metadata.
/// - author (str): Shown on the cover and in the PDF metadata.
/// - school (str, content): TUM school awarding the degree, as it should
///   appear on the cover.
/// - degree (str, content): Degree in German, e.g.
///   `"Doktors der Ingenieurwissenschaften (Dr.-Ing.)"`.
/// - chair (str, content, none): Chair of the committee (Vorsitz). `none`
///   leaves the line empty.
/// - examiners (array): Examiners in order. A `none` entry keeps its numbered
///   line empty.
/// - submission-date (datetime, none): `none` leaves a gap to fill in by hand.
/// - acceptance-date (datetime, none): Same as `submission-date`.
/// - lang (str): Language of the main text. The cover is always German.
/// - twoside (bool): For printing. Chapters start on right-hand pages and the
///   margins mirror.
/// - abstract (content, none): English abstract, omitted if `none`.
/// - zusammenfassung (content, none): German abstract, omitted if `none`.
/// - acknowledgements (content, none): Omitted if `none`.
/// - list-of-figures (bool): Whether to print the list of figures.
/// - list-of-tables (bool): Whether to print the list of tables.
/// - bibliography (content, none): A `bibliography(...)` call, placed after
///   the last chapter.
/// -> content
#let dissertation(
  title: [],
  author: "",
  school: "TUM School of Computation, Information and Technology",
  degree: "Doktors der Naturwissenschaften (Dr. rer. nat.)",
  chair: none,
  examiners: (none, none),
  submission-date: none,
  acceptance-date: none,
  lang: "en",
  twoside: false,
  abstract: none,
  zusammenfassung: none,
  acknowledgements: none,
  list-of-figures: true,
  list-of-tables: true,
  bibliography: none,
  body,
) = {
  assert(
    type(examiners) == array,
    message: "tum-dissertation: `examiners` must be an array, got " + repr(examiners) + ".",
  )

  set document(title: title, author: author)

  set page(
    paper: "a4",
    margin: if twoside {
      (inside: 30mm, outside: 25mm, top: _top-margin, bottom: 30mm)
    } else {
      (x: 27.5mm, top: _top-margin, bottom: 30mm)
    },
    header: _running-header(twoside),
    header-ascent: 40%,
    numbering: "i",
    number-align: center,
    footer: context {
      // Chapter pages have no header, so the page number goes down here.
      if _is-chapter-start() {
        align(center, text(font: _fonts.sans, size: 9pt, counter(page).display()))
      }
    },
  )

  set text(font: _fonts.serif, size: 11pt, lang: lang)
  set par(justify: true, leading: 0.65em, spacing: 1.1em)
  show raw: set text(font: _fonts.mono, size: 0.9em)
  show math.equation: set text(font: _fonts.math)

  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading: set text(font: _fonts.sans, weight: "bold")
  show heading: set block(above: 1.6em, below: 0.9em)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 3): set text(size: 12pt)
  show heading.where(level: 4): set text(size: 11pt)

  show heading.where(level: 1): it => {
    _chapter-break(twoside)
    // Figures and equations are numbered per chapter (2.1, 2.2, ...).
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)

    set text(size: 22pt)
    set par(justify: false)
    v(20mm)
    block(below: 14mm, {
      if it.numbering != none {
        text(fill: tum-colors.primary-blue, counter(heading).display(it.numbering))
        h(0.6em)
      }
      it.body
    })
  }

  let chapter-number() = counter(heading).get().first()
  set figure(numbering: n => numbering("1.1", chapter-number(), n))
  set math.equation(numbering: n => numbering("(1.1)", chapter-number(), n))
  show figure.caption: set text(size: 10pt)
  show figure.where(kind: table): set figure.caption(position: top)

  _cover(
    title: title,
    author: author,
    school: school,
    degree: degree,
    chair: chair,
    examiners: examiners,
    submission-date: submission-date,
    acceptance-date: acceptance-date,
  )

  _frontmatter(
    abstract: abstract,
    zusammenfassung: zusammenfassung,
    acknowledgements: acknowledgements,
    list-of-figures: list-of-figures,
    list-of-tables: list-of-tables,
  )

  // Main matter starts on a right-hand page as page 1.
  _chapter-break(twoside)
  set page(numbering: "1")
  counter(page).update(1)

  body

  if bibliography != none {
    set heading(numbering: none)
    bibliography
  }
}

/// Numbers the following chapters A, B, C, ... instead of 1, 2, 3.
///
/// Use it as a show rule after the last regular chapter:
/// ```typ
/// #show: appendix
/// ```
///
/// -> content
#let appendix(body) = {
  set heading(numbering: "A.1")
  show heading.where(level: 1): set heading(supplement: [Appendix])
  counter(heading).update(0)
  let chapter-number() = counter(heading).get().first()
  set figure(numbering: n => numbering("A.1", chapter-number(), n))
  set math.equation(numbering: n => numbering("(A.1)", chapter-number(), n))
  body
}
