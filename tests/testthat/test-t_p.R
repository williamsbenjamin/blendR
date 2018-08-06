context("t_p")

s_design <- survey::svydesign(
  id = ~ psu,
  strat = ~
    stratum,
  prob = ~
    prob,
  nest = T,
  data = red_snapper_sampled
)

tp <-
  t_p(
    data = red_snapper_sampled,
    recapture_total = number_caught_ps,
    captured = captured_indicator,
    survey_design = s_design,
    capture_units = nrow(self_reports)
  )

test_that("output is in right format",{
  expect_is(tp$total,"numeric")
  expect_is(tp$se,"numeric")
})
