#' @title Generalized Capture-Recapture Estimator of Total for Complex Sample,
#'   Using Values of Total from Capture Sample as Auxiliary Information
#' @description Make an Estimate of Total Using a Generalized Capture-Recapture
#'   Estimator from Liu et al (2017) for a Complex Sample Setting. Uses total of
#'   variable of interest from the capture sample as auxiliary information
#' @param recapture_total Variable of Total of Interest from a Recapture Sample
#'   Observation
#'
#' @param captured_total Variable of Total of Interest Obtained in Capture Sample
#'   Observation
#' @param survey_design A complex survey design specified with
#'   \code{survey::svydesign()}
#' @param na_remove Remove NA's? Logical
#' @param total_from_capture Total of Variable of Interest from all Units in the
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
#'
#' @example
#'   s_design <- survey::svydesign(id = ~psu,
#'                                strat = ~stratum,
#'                                prob = ~prob,
#'                                nest = T,
#'                                data = red_snapper_sampled)
#'   t_c(recapture_total = red_snapper_sampled$number_caught_ps,
#'       captured_total = red_snapper_sampled$number_caught_np,
#'       survey_design = s_design,
#'       total_from_capture = sum(self_reports$number_kept))
#' @export

 t_c <- function(recapture_total,
                 captured_total,
                 survey_design,
                 na_remove=TRUE,
                 total_from_capture){
   tc_ratio <- survey::svyratio(~recapture_total,
                                ~captured_total,
                                design = survey_design,
                                na.rm = na_remove)
   tot_c <- stats::predict(tc_ratio,
                           total= total_from_capture,
                           na.rm = na_remove)$`total`
   se_c <- stats::predict(tc_ratio,
                          total=total_from_capture,
                          na.rm = na_remove)$se
   return(list(total = tot_c,
               se = se_c))
 }
