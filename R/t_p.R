#' @title Generalized Capture-Recapture Estimator, Extension of Pollock et al's Estimator of Total
#'
#' @description Make an Estimate of Total Using Pollock et al's (1994) Estimator
#'   Generalized by Liu et al (2017) for a Complex Sample Setting. Use number of
#'   capture units as auxiliary information
#'
#' @param data A data frame, each row is an observation from the recapture sample,
#'  containing information gathered in the recapture sample, whether or not the unit
#'  is also in the capture sample, and sample design information.
#'
#' @param recapture_total Name of variable of interest recorded in the recapture
#'  sample, from given data frame
#'
#' @param captured Name of indicator variable of the sampled unit also being in the
#'  capture sample, from given data frame
#'
#' @param survey_design A complex survey design specified with
#'   \code{survey::svydesign()}
#'
#' @param na_remove Remove NA's? Logical
#'
#' @param capture_units Total number of units in the capture sample
#'
#' @details This estimator is a ratio estimator defined by: \eqn{t_p = n_1
#'   \frac{\hat{t}_y}{\hat{n}_1}} with ratio \eqn{ t_y / n_1}. \eqn{\hat{t}_y =
#'   \sum{i=1}^{N}w_i  z_i  y_i} where \eqn{z_i} is a sampling indicator,
#'   \eqn{w_i} is the sampling weight, and \eqn{y_i} is the value of the
#'   variable of interest observed in the recapture sample. There are \eqn{N}
#'   units in the population. \eqn{n_1} is the total number of units seen in the
#'   capture sample and is estimated by \eqn{\hat{n}_1 = \sum{i=1}^{N}w_i z_i
#'   r_i} where \eqn{r_i} is an indicator of whether the unit is a member of the
#'   recapture sample was seen in the capture sample.
#'
#' @return Estimate of Total and Standard Error of Estimate
#'   \item{total}{Estimate of total of a variable in population}
#'   \item{se}{Standard error of estimate of total}
#'
#' @examples
#'   s_design <- survey::svydesign(id = ~psu,
#'                                strat = ~stratum,
#'                                prob = ~prob,
#'                                nest = T,
#'                                data = red_snapper_sampled)
#'
#'   t_p(data = red_snapper_sampled,
#'       recapture_total = number_caught_ps,
#'       captured = captured_indicator,
#'       survey_design = s_design,
#'       capture_units = nrow(self_reports))
#'
#'
#' @export

t_p <- function(data,
                recapture_total,
                captured,
                survey_design,
                na_remove=T,
                capture_units){
  recapture_total <- deparse(substitute(recapture_total))
  captured <- deparse(substitute(captured))
  tp_ratio <- survey::svyratio(~data[[recapture_total]],
                               ~data[[captured]],
                               design = survey_design,
                               na.rm = na_remove)
  tot_p <- stats::predict(tp_ratio,
                           total=capture_units,
                           na.rm = na_remove)$`total`
  se_p <- stats::predict(tp_ratio,
                          total=capture_units,
                          na.rm = na_remove)$se
  return(list(total = tot_p[1,1],
              se = se_p[1,1]))
}
