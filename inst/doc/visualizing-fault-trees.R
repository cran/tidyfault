## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  comment = "#>",
  message = FALSE,
  warning = FALSE,
  fig.width = 7,
  fig.height = 4.5,
  fig.align = "center",
  dpi = 300
)

## -----------------------------------------------------------------------------
library(tidyfault)
library(ggplot2)

data("db_nodes")
data("db_edges")

gg_db <- illustrate(nodes = db_nodes, edges = db_edges, type = "all")
plot(
  gg_db,
  gate_fill = c(top = "#382a54", and = "#395d9c", or = "#3eb4ad", "basic event" = "#def5e5")
)

## -----------------------------------------------------------------------------
data("it_security_nodes")
data("it_security_edges")

gg_sec <- illustrate(
  nodes = it_security_nodes,
  edges = it_security_edges,
  type = "both"
)
plot(
  gg_sec,
  gate_fill = c(top = "#382a54", and = "#395d9c", or = "#3eb4ad", "basic event" = "#def5e5")
)

