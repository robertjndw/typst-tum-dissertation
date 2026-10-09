#import "tum-dissertation/lib.typ": appendix, dissertation, tum-colors

#show: dissertation.with(
  title: [Title of Your Dissertation],
  author: "Your Name",
  school: "TUM School of Computation, Information and Technology",
  // e.g. "Doktors der Ingenieurwissenschaften (Dr.-Ing.)"
  degree: "Doktors der Naturwissenschaften (Dr. rer. nat.)",
  // Leave as none until you know the committee, the line stays empty.
  chair: none,
  examiners: ("Prof. Dr. First Examiner", none),
  // Set once known, e.g. datetime(year: 2026, month: 10, day: 9).
  submission-date: none,
  acceptance-date: none,
  lang: "en",
  twoside: false,
  abstract: include "chapters/abstract.typ",
  zusammenfassung: include "chapters/zusammenfassung.typ",
  acknowledgements: none,
  bibliography: bibliography("references.bib", title: [Bibliography], style: "ieee"),
)

#include "chapters/01-introduction.typ"
#include "chapters/02-background.typ"
#include "chapters/03-conclusion.typ"

#show: appendix
#include "chapters/a-appendix.typ"
