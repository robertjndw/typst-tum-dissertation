// The sample dissertation in print layout. Chapters start on odd pages, so
// the blank pages in between must have neither header nor page number.
#import "../tum-dissertation/lib.typ": appendix, dissertation

#show: dissertation.with(
  title: [Title of Your Dissertation],
  author: "Erika Mustermann",
  examiners: ("Prof. Dr. First Examiner", "Prof. Dr. Second Examiner"),
  chair: "Prof. Dr. Chair",
  submission-date: datetime(year: 2026, month: 10, day: 9),
  acceptance-date: datetime(year: 2027, month: 1, day: 15),
  twoside: true,
  abstract: include "../chapters/abstract.typ",
  zusammenfassung: include "../chapters/zusammenfassung.typ",
  bibliography: bibliography("../references.bib", title: [Bibliography], style: "ieee"),
)

#include "../chapters/01-introduction.typ"
// Long enough to get running headers on both even and odd pages.
#lorem(1500)
#include "../chapters/02-background.typ"
#include "../chapters/03-conclusion.typ"

#show: appendix
#include "../chapters/a-appendix.typ"
