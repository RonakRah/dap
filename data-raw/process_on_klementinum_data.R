## code to prepare `DATASET` dataset goes here

library(data.table)
library(dplyr)
library(raster)


#              |||| **** observed data **** ||||
path <- "data-raw/"
txt_files <- list.files(paste0(path,"txt_files"),
                        pattern = "*.txt",
                        full.names = TRUE)

#loading observed data
pr_observed <- fread(txt_files[2], na.strings = '-9999')
temprature_observ <- fread(txt_files[3], na.strings = '-9999')

pr_observed = pr_observed[!is.na(RR)]
pr_observed[,pr_o := RR/10]
pr_observed[, DTM := as.Date(as.character(DATE), format = '%Y%m%d')]
pr_observed[,.(DTM,pr_o)] # dropping unnecessary col

temprature_observ[,tem_o := TG/10]
temprature_observ = temprature_observ[!is.na(tem_o)]
temprature_observ[, DTM := as.Date(as.character(DATE), format = '%Y%m%d')]
temprature_observ = temprature_observ[,.(DTM,tem_o)] # dropping unnecessary col

# create a comprehensive observed data by inner joining both data tables
observed_data <- pr_observed %>%
  inner_join(temprature_observ)
observed_data=observed_data[,.(DTM,pr_o,tem_o)]

#              |||| **** Model simulated data **** ||||

nc_files <- list.files(paste0(path,"nc_files"),
                       pattern = "*.nc",
                       full.names = TRUE)
pr_raster <- raster(nc_files[1])
tem_raster <- raster(nc_files[2])
#             |||| ***** turn the data to a download able format
#                             (.rda) in data directory ***** ||||
usethis::use_data(pr_raster,compress = "xz", overwrite = TRUE)
usethis::use_data(tem_raster,compress = "xz", overwrite = TRUE)
usethis::use_data(observed_data, compress = "xz", overwrite = TRUE)

