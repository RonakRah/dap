
#' b_finder
#'
#' @param d    the difference between 90 percent quantifies
#' @param l    quantile 90 percent of future scenario
#' @param g    the difference between 60 percent quantifies
#' @param h    quantile 60 percent of future scenario
#' @param c    quantile 90 percent of controlled time
#' @param o    quantile 60 percent of controlled time
#'
#' @return numeric value
#' @export
#'
#' @examples
b_finder <- function(d,l,g,h,c,o){
  b <- log((d * l)/(g * h))/log((d * c)/(g * o) )
  b
}
