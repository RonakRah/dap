library(data.table)


#' comparer_plots
#' @description this function plot two different data to compare them with each other , it mostly used to compare observed data and simulated data
#' @param ob_data your observed data in form of data frame
#' @param sim_data your simulated data in a form of data frame
#'
#' @return
#' @export
#'
#' @examples
compare_plots <- function(ob_data,sim_data){


  first <- ob_data
  sec <- sim_data
  par(mfrow=c(1,2))
  plot(first,main="observed data")
  plot(sec,main="simulated data")
}


