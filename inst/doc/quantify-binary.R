## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(tidyfault)
library(dplyr)
library(purrr)
library(tibble)

data("db_nodes")
data("db_edges")

f <- curate(db_nodes, db_edges) |>
  equate() |>
  formulate()
sort(names(formals(f)))

## -----------------------------------------------------------------------------
f(DC = 1, AF = 1, SF = 0, BF = 0, NF = 0, AUF = 0, HF = 0, MF = 0)

## -----------------------------------------------------------------------------
data("db_outcomes_binary")
head(db_outcomes_binary)

## -----------------------------------------------------------------------------
mybinary <- quantify(f, newdata = db_outcomes_binary)
mybinary

## -----------------------------------------------------------------------------
data("it_security_nodes")
data("it_security_edges")
data("it_security_probs")

f_sec <- formulate(equate(curate(it_security_nodes, it_security_edges)))

set.seed(123)
n_binary <- 5000
batch_binary <- it_security_probs |>
  map(~ rbinom(n_binary, size = 1, prob = .x)) |>
  as_tibble()

outcomes_batch <- quantify(f_sec, newdata = batch_binary)
table(outcomes_batch)
mean(outcomes_batch)

