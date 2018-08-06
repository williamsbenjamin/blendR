context("t_c")

s_design <- survey::svydesign(
  id = ~ psu,
  strat = ~
    stratum,
  prob = ~
    prob,
  nest = T,
  data = red_snapper_sampled
)


tc <- t_c(
    data = red_snapper_sampled,
    recapture_total = number_caught_ps,
    captured_total = number_caught_np,
    survey_design = s_design,
    total_from_capture = sum(self_reports$number_kept)
  )

test_that("output is in right format",{
  expect_is(tc$total,"numeric")
  expect_is(tc$se,"numeric")
})
