

#' tem_var_plot
#'
#'
#' it plots how the variability of tempereture changes
#'
#' @param ss standard deviation of scenario period
#' @param sc standard deviation of control period
#'
#' @return  a plot
#' @export
#'
#' @examples
tem_var_plot <- function(ss,sc){
  plot(ss/sc)
  abline(h=1.0,col="orange",lty=2, lwd= 3)

}
