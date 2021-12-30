


#' pr_trans_under
#' @description transition of precipitation under 90 percent quantile.the value of observed precipitation given to the function should be less than 90 percent quentile
#' @param a parameter ,can be find by a_finder function
#' @param pr observed precipitation
#' @param b  parameter , can be find by b_finder function
#'
#' @return  numeric value
#' @export
#'
#' @examples
pr_trans_under <- function(a,pr,b){
  pr_transition <- a * pr^b
  pr_transition
}



#' pr_trans_upon
#' @description transition of precipitation upon 90 percent quantile.the value of observed precipitation given to the function should be greater than 90 percent quentile
#' @param E the difference between mean exceedance of future and control scenario
#' @param pr observed precipitation ,the value of observed precipitation given to the function should be greater than 90 percent quentile
#' @param q  quantile 90 percent
#' @param a  parameter, you can find it by a_finder function
#' @param b  parameter, you can find it by b_finder function
#'
#' @return
#' @export
#'
#' @examples
pr_trans_upon <- function(E,pr,q,a,b){
  pr_transition <- E * (pr - q) + a * q ^ b
  pr_transition
}


#' tem_trans_finder
#' @description this function find the temperature transition
#' @param o mean of observed temperature
#' @param f mean of future temperature
#' @param c mean of controlled scenario temperature
#' @param t observed temperature
#' @param s difference between standard deviation of future temperature and controlled temperature scenario you can find it by dif_finder function
#'
#' @return
#' @export
#'
#' @examples
tem_trans_finder <- function(o,f,c,t,s){
  tem_trans <- o + f - c + (t - o) * s
  tem_trans
}
