context("t_diff")

s_design <- survey::svydesign(
  id = ~ psu,
  strat = ~
    stratum,
  prob = ~ prob,
  nest = T,
  data = red_snapper_sampled
)

t_d <- t_diff(
  data = red_snapper_sampled,
  delta = delta_catch,
  survey_design = s_design,
  na_remove = TRUE,
  total_from_capture = sum(self_reports$number_kept)
)

test_that("output is in right format",{
  expect_is(t_d$total,"numeric")
  expect_is(t_d$se,"numeric")
})
