## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(tidyfault)
library(dplyr)
library(tidyr)

data("it_security_nodes")
data("it_security_edges")
data("it_security_probs")

f <- formulate(equate(curate(it_security_nodes, it_security_edges)))

## -----------------------------------------------------------------------------
set.seed(7)
t_horizon <- 10000
cv <- 0.2
n_draws <- 2500

batch_probs <- it_security_probs |>
  pivot_longer(everything(), names_to = "event", values_to = "prob") |>
  mutate(
    lambda = -log(1 - prob) / t_horizon,
    lambda_se = lambda * cv
  ) |>
  group_by(event) |>
  reframe(
    prob = pexp(
      q = t_horizon,
      rate = rnorm(n = n_draws, mean = lambda, sd = lambda_se)
    ),
    scenario = seq_len(n_draws)
  ) |>
  ungroup() |>
  pivot_wider(id_cols = scenario, names_from = event, values_from = prob)

event_cols <- setdiff(names(batch_probs), "scenario")
sim_probs <- batch_probs
sim_probs$outcome <- quantify(
  f,
  newdata = sim_probs[, event_cols, drop = FALSE],
  prob = TRUE
)

knitr::kable(head(sim_probs, 3), digits = 4)

## -----------------------------------------------------------------------------
sim_probs |>
  summarize(
    estimate = mean(outcome),
    lower = quantile(outcome, 0.025),
    upper = quantile(outcome, 0.975)
  ) |>
  knitr::kable(digits = 4)

