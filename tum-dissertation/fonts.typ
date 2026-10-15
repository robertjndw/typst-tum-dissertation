// TUM Neue Helvetica is the TUM corporate font. The other families in each
// list are free fallbacks, closest to the Latin Modern Sans and Nimbus Sans the
// cover was measured from, for anyone who removes the TUM font. None of these
// are built into Typst, which is why they're in `fonts/`.
#let _fonts = (
  serif: "New Computer Modern",
  sans: ("TUM Neue Helvetica", "New Computer Modern Sans"),
  mono: "DejaVu Sans Mono",
  math: "New Computer Modern Math",
  cover-header: ("TUM Neue Helvetica", "TeX Gyre Heros"),
)
