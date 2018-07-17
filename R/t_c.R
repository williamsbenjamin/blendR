#' @title Generalized Capture-Recapture Estimator of Total for Complex Sample,
#'   Using Values of Total from Capture Sample as Auxiliary Information
#' @description Make an Estimate of Total Using a Generalized Capture-Recapture
#'   Estimator from Liu et al (2017) for a Complex Sample Setting. Uses total of
#'   variable of interest from the capture sample as auxiliary information.
#'
#' @param data A data frame, each row is an observation from the recapture sample.
#'   If the row refers to a unit which is also in the capture sample, the data frame
#'   contains the information gathered from the recapture sample. If the row refers
#'   to a unit in the recapture sample only, those columns for recapture sample data
#'   contain zeros. The data frame also should contain sample design information.
#'
#' @param recapture_total Name of variable of interest recorded in recapture sample
#'   Observation, from given data frame
#'
#' @param captured_total Name of variable of interest as Recorded in Capture Sample,
#' from given data frame. \code{captured_total} = 0 if unit is in the Recapture Sample Only
#'
#' @param survey_design A complex survey design, specified with
#'   \code{survey::svydesign()}
#'
#' @param na_remove Remove NA's? Logical
#'
#' @param total_from_capture Total of Variable of Interest from all Units in the
#'   Capture Sample
#'
#' @details This estimator is a ratio estimator defined by: \eqn{t_c = t_y*
#'   \frac{\hat{t}_y}{\hat{t}_y*}} with ratio \eqn{ t_y / t_y*}. \eqn{\hat{t}_y
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
#' @examples
#'   s_design <- survey::svydesign(id = ~psu,
#'                                strat = ~stratum,
#'                                prob = ~prob,
#'                                nest = T,
#'                                data = red_snapper_sampled)
#'   t_c(data = red_snapper_sampled,
#'       recapture_total = number_caught_ps,
#'       captured_total = number_caught_np,
#'       survey_design = s_design,
#'       total_from_capture = sum(self_reports$number_kept))
#' @export

 t_c <- function(data,
                 recapture_total,
                 captured_total,
                 survey_design,
                 na_remove=TRUE,
                 total_from_capture){
   recapture_total <- deparse(substitute(recapture_total))
   captured_total <- deparse(substitute(captured_total))
   tc_ratio <- survey::svyratio(~data[[recapture_total]],
                                ~data[[captured_total]],
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
