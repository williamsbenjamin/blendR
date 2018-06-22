#' @title Generalized Capture-Recapture Estimator of Total for Complex Sample,
#'   Using Values of Total from Capture Sample as Auxiliary Information'
#' @description Make an Estimate of Total Using a Generalized Capture-Recapture
#'   Estimator from Liu et al (2017) for a Complex Sample Setting. Uses total of
#'   variable of interest from the capture sample as auxiliary information
#' @param delta For Every Unit in the Recapture Sample, Delta is the value of
#'   the variable of interest Observed in the Recapture Sample minus the value
#'   observed in the Capture Sample
#' @param captured Indicator Variable of Unit being in Capture Sample
#' @param captured_total Variable of Total of Interest from a Capture Sample
#'   Observation
#' @param survey_design A complex survey design specified with
#'   \code{survey::svydesign()}
#' @param na_remove Remove NA's? Logical
#' @param capture_units Total of Variable of Interest from all Units in the
#'   Capture Sample
#' @details This estimator is a ratio estimator defined by: \eqn{t_c = t_y*
#'   \frac{\hat{t}_y}{\hat{t}_y*}} with ratio \eqn{ t_y / t_y*}. \eqn{\hat{t}_y
#'   = \sum{i=1}^{N}w_i  z_i  y_i} where \eqn{z_i} is a sampling indicator,
#'   \eqn{w_i} is the sampling weight, and \eqn{y_i} is the value of the
#'   variable of interest observed in the recapture sample. There are \eqn{N}
#'   units in the population. \eqn{y*_i} is the value of the variable of
#'   interest recorded in the recapture sample. \eqn{t_y* = \sum{i
#'   =1}^{N}r_iy*_i} \eqn{r_i} is an indicator of whether the unit is a member
#'   of the recapture sample.
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
