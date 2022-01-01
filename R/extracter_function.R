
library(data.table)
library(dplyr)
library(raster)
library(ncdf4)
library(terra)
library(sf)
library(ggplot2)
library(tidyr)


#' extractor
#' @description extract chosen values from a raster
#' @param from input "raster" that you want to extract from
#' @param by input "vector" that you want to extract by
#'
#' @return a raster
#' @export
#'
#' @examples
extract_my_data <- function(from,by){

  model = terra::extract(from,terra::vect(by))
  model

}
