



#' mean_ex_finder
#' @description this function finds the mean exeedance ,the value choosen for precipitation better be greater than quantile 90 percent
#' @param pr precipitation
#' @param q  quantile 90 percent
#'
#' @return a numeric value
#' @export
#'
#' @examples
mean_ex_finder <-function(pr,q){
  m_ex <- mean(pr - q)
  m_ex
}

