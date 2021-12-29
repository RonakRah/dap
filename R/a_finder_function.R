#' a_finder
#'
#' @param qt   quantile 60 percent of future scenario
#' @param qc    quantile 60 percent of controlled scenario
#' @param b    parameter can be find by  b_finder function
#' @param g   the difference between 60% quantiles
#'
#' @return a numeric value
#' @export
#'
#' @examples
a_finder <- function(qt,qc,b,g1){
  a <- qt / (qc^b) * g1^(1-b)
  a
}

