
library(ggplot2)

#' b_plot
#'
#'
#'plot b parameter which show the changes in extreme precipitation
#'
#' @param b b parameter
#'
#' @return a plot
#' @export
#'
#' @examples
b_plot <- function(b){

  plot(b)
  abline(h=c(1.3,1.5),col=c("blue", "red"),lty=c(1,2), lwd=c(1, 3))
}
