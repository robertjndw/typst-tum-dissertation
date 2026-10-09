// Chapter page breaks and the running header.

#import "fonts.typ": _fonts

// A heading's location is recorded before its show rule runs, so it points
// to the page before this break. Header and footer therefore look at
// <chapter-start> instead. <chapter-end> marks the last page of the previous
// chapter, everything in between is an empty filler page.
#let _chapter-break(twoside) = {
  [#metadata(none) <chapter-end>]
  pagebreak(weak: true, to: if twoside { "odd" })
  [#metadata(none) <chapter-start>]
}

#let _is-chapter-start() = {
  let current-page = here().page()
  query(<chapter-start>).any(m => m.location().page() == current-page)
}

#let _top-margin = 30mm

// The end marker can also sit at the very top of an empty page (e.g. the
// back of the cover), which counts as filler too.
#let _is-blank-page() = {
  let current-page = here().page()
  let next = query(<chapter-start>).filter(m => m.location().page() > current-page)
  if next.len() == 0 { return false }
  let start-page = next.first().location().page()
  // Markers on the start page itself come from breaks that did nothing.
  let ends = query(selector(<chapter-end>).before(next.first().location()))
    .filter(m => m.location().page() < start-page)
  if ends.len() == 0 { return false }
  let end = ends.last().location().position()
  end.page < current-page or (end.page == current-page and end.y <= _top-margin + 1pt)
}

#let _running-header(twoside) = context {
  if _is-blank-page() or _is-chapter-start() { return }

  let previous = query(heading.where(level: 1).before(here()))
  let chapter = if previous.len() > 0 {
    let current = previous.last()
    if current.numbering != none {
      // Only the chapter part, so the appendix shows "A" instead of "A.".
      numbering(current.numbering, counter(heading).at(current.location()).first())
      h(0.8em)
    }
    current.body
  }
  let number = counter(page).display()

  set text(font: _fonts.sans, size: 9pt)
  if twoside and calc.even(here().page()) {
    number + h(1fr) + chapter
  } else {
    chapter + h(1fr) + number
  }
  v(-0.6em)
  line(length: 100%, stroke: 0.4pt)
}
