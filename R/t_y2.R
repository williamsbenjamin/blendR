#' @title Multivariate Ratio Estimator of Total for Complex Sample
#'
#' @description Make an Estimate of Total Using a Weighted Combination of
#'   \code{\link{t_p}} and \code{\link{t_y2}} from Liu et al (2017) for a
#'   Complex Sample Setting.
#'
#' @param data A data frame, each row is an observation from the recapture sample.
#'   If the row refers to a unit which is also in the capture sample, the data frame
#'   contains the information gathered from the recapture sample. If the row refers
#'   to a unit only in the recapture sample, those columns for recapture sample data
#'   contain zeros. The data frame should contain a variable delta, see below, and
#'   and sample design information.
#'
#' @param delta Name of variable from given data frame. For every unit in the
#'   recapture sample, delta is the value of the variable of interest observed
#'   in the recapture sample minus the value observed in the capture sample. If the
#'   unit in the recapture sample is not also a member of the capture sample,
#'   \code{delta =0}
#'
#' @param captured Name of indicator variable of unit being in capture sample,
#'  from given data frame
#'
#' @param survey_design A complex survey design specified with
#'   \code{survey::svydesign()}
#'
#' @param na_remove Remove NA's? Logical
#'
#' @param capture_units Total number of units in the capture sample
#'
#' @param total_from_capture Total of variable of interest from all units in the
#'   capture sample
#'
#' @details This estimator is defined by: \eqn{t_y2 = t_{y*} +
#'   \frac{n_1}{\hat{n}_1}(\hat{t}_y - \hat{t}_{y*}) = t_{y*} +
#'   n_1\hat{bar{\delta}}}. This amounts to a ratio estimator of \eqn{\delta}
#'   over \eqn{\hat{n_1}} with auxiliary information \eqn{n_1} added to \eqn{t_{y*}}.
#'   \eqn{\delta = y_i - r_iy*_i}, \eqn{\hat{t}_y = \sum{i=1}^{N}w_i  z_i y_i},
#'   \eqn{z_i} is a sampling indicator, \eqn{w_i} is the sampling weight,
#'   \eqn{y_i} is the value of the variable of interest observed in the
#'   Recapture sample, \eqn{y*_i} is the value of the variable of interest
#'   observed in the Capture sample. There are \eqn{N} units in the population.
#'   \eqn{y*_i} is the value of the variable of interest recorded in the
#'   recapture sample. \eqn{t_{y*} = \sum{i =1}^{N}r_iy*_i} \eqn{r_i} is an
#'   indicator of whether the unit is a member of the recapture sample.
#'
#' @return Estimate of Total and Standard Error of Estimate
#'   \item{total}{Estimate of total of variable of interest in population}
#'   \item{se}{Standard error of estimate of total}
#'
#'  @example
#'  s_design <- survey::svydesign(id = ~psu,
#'                                strat = ~stratum,
#'                                prob = ~prob,
#'                                nest = T,
#'                                data = red_snapper_sampled)
#' t_y2(data = red_snapper_sampled,
#'      delta = delta_catch,
#'      captured = captured_indicator,
#'      capture_units = nrow(self_reports),
#'      total_from_capture = sum(self_reports$number_kept)
#'      )
#' @export

t_y2 <- function(data,
                 delta,
                 captured,
                 survey_design,
                 na_remove=T,
                 capture_units,
                 total_from_capture){
  delta <- deparse(substitute(delta))
  captured <- deparse(substitute(captured))
  t_y2_ratio <- survey::svyratio(~data[[delta]],
                               ~data[[captured]],
                               design = survey_design,
                               na.rm = na_remove)
  tot_y2 <- stats::predict(t_y2_ratio,
                          total = capture_units,
                          na.rm = na_remove)[[1]] + total_from_capture
  se_y2 <- stats::predict(t_y2_ratio,
                         total = capture_units,
                         na.rm = na_remove)$se
  return(list(total = tot_y2,
              se = se_y2))
}
