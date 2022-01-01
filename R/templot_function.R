
#'
#' tem_plot
#'
#'
#' show the changes of tempreture
#'
#' @param ms mean tempreture of scenario period
#' @param mc mean tempreture of control period
#'
#' @return a plot
#' @export
#'
#' @examples
tem_plot<- function(ms,mc){

  plot(ms-mc,main="the change of tempreture")
}
