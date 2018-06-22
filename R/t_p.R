#' @title Generalized Pollock et al's Estimator of Total
#'
#' @description Make an Estimate of Total Using Pollock et al's (1994) Estimator
#'   Generalized by Liu et al (2017) for a Complex Sample Setting. Use number of
#'   capture units as auxiliary information
#' @param recapture_total Variable of Total of Interest from a Recapture Sample
#'   Observation
#'
#' @param captured Indicator Variable of Unit being in Capture Sample
#' @param survey_design A complex survey design specified with
#'   \code{survey::svydesign()}
#' @param na_remove Remove NA's? Logical
#' @param capture_units Total Number of Units in the Capture Sample
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
#'   \item{total}{Estimate of Total of a Variable in Population}
#'   \item{se}{Standard Error of Estimate of Total}
#' @export

t_p <- function(recapture_total,
                captured,
                survey_design,
                na_remove=T,
                capture_units){
  tp_ratio <- survey::svyratio(~recapture_total,
                               ~captured,
                               design = survey_design,
                               na.rm = na_remove)
  tot_p <- stats::predict(tp_ratio,
                           total=capture_units,
                           na.rm = na_remove)$`total`
  se_p <- stats::predict(tp_ratio,
                          total=capture_units,
                          na.rm = na_remove)$se
  return(list(total = tot_p,
              se = se_p))
}
