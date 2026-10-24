## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(tidyfault)
library(dplyr)

data("db_nodes")
data("db_edges")

knitr::kable(head(db_nodes, 6), caption = "Nodes (excerpt)")
knitr::kable(head(db_edges, 6), caption = "Edges (excerpt)")

## -----------------------------------------------------------------------------
gates <- curate(nodes = db_nodes, edges = db_edges)
gates

## -----------------------------------------------------------------------------
equation <- equate(gates)
equation

## -----------------------------------------------------------------------------
f <- formulate(equation)
sort(names(formals(f)))

## -----------------------------------------------------------------------------
truth <- calculate(f)
dim(truth)
sum(truth$outcome) # failure scenarios

## -----------------------------------------------------------------------------
mymin <- concentrate(gates)
mymin

## -----------------------------------------------------------------------------
mytab <- tabulate(mymin, formula = f)
knitr::kable(mytab, digits = 4)

