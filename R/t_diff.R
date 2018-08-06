#' @title Difference Estimator of Total
#'
#' @description Make an estimate of total using a difference estimator
#' proposed by Breidt et al (2018). The estimator assumes the sampling frame
#' is complete, and there is no undercoverage.
#'
#' @details This estimator is a difference estimator defined by:
#' \eqn{t_{diff} = t_y* + (\hat{t}_y - \hat{t}^*_y)} \eqn{\hat{t}_y
#'   = \sum{i=1}^{N}w_i  z_i  y_i} where \eqn{z_i} is a sampling indicator,
#'   \eqn{w_i} is the sampling weight, and \eqn{y_i} is the value of the
#'   variable of interest observed in the recapture sample. There are \eqn{N}
#'   units in the population. \eqn{y*_i} is the value of the variable of
#'   interest recorded in the recapture sample. \eqn{t_y* = \sum{i
#'   =1}^{N}r_iy*_i} \eqn{r_i} is an indicator of whether the unit is a member
#'   of the recapture sample.
#'
#' @return Estimate of Total and Standard Error of Estimate
#'   \item{total}{Estimate of total of variable of interest in population}
#'   \item{se}{Standard error of estimate of total}
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
#' @param survey_design A complex survey design, specified with
#'   \code{survey::svydesign()}
#'
#' @param na_remove Remove NA's? Logical
#'
#' @param total_from_capture Total of variable of interest from all units in the
#'   capture sample#'
#'
#' @examples
#'   s_design <- survey::svydesign(id = ~psu,
#'                                strat = ~stratum,
#'                                prob = ~prob,
#'                                nest = T,
#'                                data = red_snapper_sampled)
#'   t_diff(data = red_snapper_sampled,
#'       delta = delta_catch,
#'       survey_design = s_design,
#'       na_remove = TRUE,
#'       total_from_capture = sum(self_reports$number_kept))
#'
#' @export
#'


t_diff <- function(data,
                   delta,
                   survey_design,
                   na_remove=T,
                   total_from_capture){
  d <- deparse(substitute(delta))
  t_diff <- survey::svytotal(~data[[d]],
                                 design = survey_design,
                                 na.rm = TRUE)
  tot_y_diff <- t_diff[[1]] + total_from_capture
  se_y_diff <- survey::SE(t_diff)
  return(list(total = tot_y_diff,
              se = se_y_diff[1,1]))
}
