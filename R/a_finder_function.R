#' a_finder
#'
#' @param qt   quantile 60 percent of future scenario
#' @param qc    quantile 60 percent of controlled scenario
#' @param b    parameter can be find by  b_finder function
#' @param g   the difference between 60 percent quantiles of observed and control scenario, "g1"
#'
#' @return a numeric value
#' @export
#'
#' @examples
a_finder <- function(qt,qc,b,g1){
  a <- qt / (qc^b) * g1^(1-b)
  a
}

