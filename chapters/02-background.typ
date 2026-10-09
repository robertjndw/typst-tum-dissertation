#import "../tum-dissertation/lib.typ": tum-colors

= Background <ch:background>

== Figures

Figures are numbered per chapter, see @fig:placeholder.

// Put your images in `figures/` and use e.g.
// `image("../figures/setup.svg", width: 80%)` instead of the rectangle.
#figure(
  rect(width: 80%, height: 4cm, fill: tum-colors.secondary-grey-light, stroke: none),
  caption: [A placeholder figure.],
) <fig:placeholder>

== Tables

#figure(
  table(
    columns: 3,
    align: (left, right, right),
    table.header[*Protocol*][*Layer*][*Year*],
    [TCP], [4], [1981],
    [QUIC], [4], [2021],
  ),
  caption: [A table with its caption on top.],
) <tab:protocols>

@tab:protocols lists a few protocols.

== Equations

Equations are numbered per chapter as well:

$ E = m c^2 $ <eq:energy>

See @eq:energy.
