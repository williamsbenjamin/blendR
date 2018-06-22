#' @title Multivariate Ratio Estimator of Total for Complex Sample, from Liu et
#'   al (2017)
#' @description Make an Estimate of Total Using a Weighted Combination of
#'   \code{\link{t_p}} and \code{\link{t_y2}} from Liu et al (2017) for a
#'   Complex Sample Setting.
#' @param delta For Every Unit in the Recapture Sample, Delta is the Value of
#'   the Variable of Interest Observed in the Recapture Sample Minus the Value
#'   Observed in the Capture Sample. \eqn{\delta = y_i - r_iy*_i} where
#'   \eqn{y_i} is the Value of the Variable of Interest for the ith unit in the
#'   Recapture Sample, \eqn{r_i} is an Indicator of whether the unit is a Member
#'   of the Capture Sample, and \eqn{y*_i} is the Value of the Variable of
#'   Interest in the Capture Sample
#' @param captured Indicator Variable of Unit being in Capture Sample
#' @param captured_total Variable of Total of Interest from a Capture Sample
#'   Observation
#' @param survey_design A complex survey design specified with
#'   \code{survey::svydesign()}
#' @param na_remove Remove NA's? Logical
#' @param capture_units Total of Variable of Interest from all Units in the
#'   Capture Sample
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
#' @return Estimate of Total and Standard Error of Estimate
#'   \item{total}{Estimate of Total of a Variable in Population}
#'   \item{se}{Standard Error of Estimate of Total}
#' @export

t_y2 <- function(delta,
                 captured,
                 survey_design,
                 na_remove=T,
                 capture_units,
                 total_from_capture){
  t_y2_ratio <- survey::svyratio(~delta,
                               ~captured,
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
