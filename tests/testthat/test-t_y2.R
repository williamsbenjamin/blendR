context("t_y2")

s_design <- survey::svydesign(
  id = ~ psu,
  strat = ~
    stratum,
  prob = ~
    prob,
  nest = T,
  data = red_snapper_sampled
)

ty2 <-
  t_y2(
    data = red_snapper_sampled,
    delta = delta_catch,
    survey_design = s_design,
    captured = captured_indicator,
    capture_units = nrow(self_reports),
    total_from_capture = sum(self_reports$number_kept)
  )

test_that("output is in right format",{
  expect_is(ty2$total,"numeric")
  expect_is(ty2$se,"numeric")
})
