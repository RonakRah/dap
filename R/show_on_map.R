library(mapview)
library(sf)


#' show_on_map
#' @description this function shows your places as points on map
#' @param place a data frame including the place with latitude and longitude
#' @param lon column name of your data frame that includes longitude values
#' @param lat column name of your data frame that includes latitude values
#'
#' @return
#' @export
#'
#' @examples
show_on_map <- function(place,lon,lat){
    points <- as_tibble(place)
    coordinates <-  as.character(quote(c(lon,lat)))[-1]
    points <-st_as_sf(points,coords=c(coordinates[1],coordinates[2]),crs=4326)
    mapview::mapview(points)}
