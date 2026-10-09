// Unnumbered headings and roman page numbers. The cover counts as page i.
#let _frontmatter(
  abstract: none,
  zusammenfassung: none,
  acknowledgements: none,
  list-of-figures: true,
  list-of-tables: true,
) = {
  set heading(numbering: none)

  if abstract != none {
    heading(outlined: false)[Abstract]
    abstract
  }
  if zusammenfassung != none {
    heading(outlined: false)[Zusammenfassung]
    text(lang: "de", zusammenfassung)
  }
  if acknowledgements != none {
    heading(outlined: false)[Acknowledgements]
    acknowledgements
  }

  {
    show outline.entry.where(level: 1): it => {
      v(0.9em, weak: true)
      let prefix = it.prefix()
      link(it.element.location(), it.indented(
        if prefix != none { strong(prefix) },
        strong(it.body()) + h(1fr) + strong(it.page()),
      ))
    }
    outline(title: [Contents], indent: auto, depth: 3)
  }
  if list-of-figures {
    outline(title: [List of Figures], target: figure.where(kind: image))
  }
  if list-of-tables {
    outline(title: [List of Tables], target: figure.where(kind: table))
  }
}
