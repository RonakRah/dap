
library(data.table)
library(dplyr)
library(raster)
library(ncdf4)
library(terra)
library(sf)
library(ggplot2)



#' extracter
#' @description extract chosen values from a raster
#' @param from input that you want to extract from. default = pr_raster
#' @param by input that you want to extract by . default = station
#'
#' @return list of numeric values
#' @export
#'
#' @examples
extracter <- function(from,by){

  pr_model = terra::extract(from,terra::vect(by))
  pr_model

}
