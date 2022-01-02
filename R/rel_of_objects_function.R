


#' rel_of_objects
#'
#'
#' plot the relation of two different variables
#'
#' @param t temperature
#' @param p precipitation
#'
#' @return a graph
#' @export
#'
#' @examples
rel_of_objects <- function(t,p){
  par(mfrow=c(1,2))
  hist(t,col="brown2",main="T")
  hist(p,col="dodgerblue2",main=" P ")

}
