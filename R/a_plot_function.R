

#' a_plot
#'
#' plot "a" parameter which is a scalar of precipitation
#'
#' @param a "a" parameter
#'
#' @return a plot
#' @export
#'
#' @examples
a_plot<- function(a){
  plot(a)
  abline(h=1.0,col="red",lty=2, lwd= 3)
}
