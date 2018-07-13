#' @title 2016 Texas Parks and Wildlife Red Snapper Capture-Recapture Dataset
#'
#'@description A dataset from a 2016 capture-recapture sampling program
#'by Texas Parks and Wildlife. A probability sample of
#'docks was selected and interviewers boarded returning charter
#'fishing boats and counted the number of Red Snapper fish caught and
#'number of anglers aboard. The captains of such boats had the opportunity
#'to voluntarily self-report the number of Red Snapper caught and number of
#'anglers aboard. Captains who self-reported were still eligible to be sampled
#'in the dockside intercept. The self-reports represent the "capture" sample
#'and the dockside intercept represents the "recapture" sample.
#'
#'@format A data frame with 398 rows and 11 variables:
#'
#'\describe{
#' \item{id}{Identificaion number of a fishing trip}
#' \item{angler_ps}{Number of anglers on fishing trip, as observed in the dockside intercept, a probability sample}
#' \item{number_caught_ps}{Number of Red Snapper fish caught as observed in the dockside intercept, a probability sample}
#' \item{stratum}{The stratum of the dockside intercept, either weekday or weekend}
#' \item{prob}{Sampling probability}
#' \item{sample_weight}{Sampling weight, reciprocal of sampling probability}
#' \item{number_caught_np}{Number of Red Snapper fish caught, as reported by captains, a non-probability sample}
#' \item{anglers_np}{Number of anglers on fishing trip,as reported by captains, a non-probability sample}
#' \item{captured_indicator}{Indicator of whether the sampled trip also self-reported}
#' \item{delta_catch}{Difference between number_caught_ps and number_caught_np}
#' \item{delta_angler}{Difference between anglers_ps and anglers_np}}
#'

"red_snapper_sampled"
