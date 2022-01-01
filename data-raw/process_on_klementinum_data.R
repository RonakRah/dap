## code to prepare `DATASET` dataset goes here

library(data.table)
library(dplyr)
library(raster)
library(terra)
library(sf)
library(ncdf4)
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
pr_raster<- rast(nc_files[1])
tem_raster <- rast(nc_files[2])

#                    |||| **** setting the station **** ||||

# 27,PRAHA-KLEMENTINUM,CZECH REPUBLIC,+50:08:66,+014:41:60,191 m
# get the station as a vector to be able to check the attributes like cells and etc..
station <-  data.frame(lon = 14 + 41/60 + 60/60/100, lat = 50 + 08/60 + 66/60/100)

pr_model = terra::extract(pr_raster,terra::vect(station))
pr_model_dt <- data.table(pr_model)
pr_model_dt <- melt(pr_model_dt,id.vars = "ID")
pr_model_brick <- brick(nc_files[1]) # to have access to different layers
pr_model_dt[,DTM := pr_model_brick@z$Date]
pr_model_dt[,value := 60*60*24*value] # changing it to daily value

tem_model = terra::extract(tem_raster,station)
tem_model_dt <- data.table(tem_model)
tem_model_dt <- melt(tem_model_dt,id.vars = "ID")
tem_model_dt[,value := value-273.15]
tem_model_brick <- brick(nc_files[2]) # to have access to different layers
tem_model_dt[,DTM := tem_model_brick@z$Date]

## create a comprehensive model simulated data by inner joining both data tables
model_data <- pr_model_dt [tem_model_dt,on="DTM"]
model_data=model_data[,.(DTM,pr=value,tem=i.value)]

#quantiles of model data

model_data[,pr_5:= frollsum(pr,5, align = "center")] # we see 1950 and 2100 we have NA
model_data = model_data[year(DTM) %in% 1951:2099]
model_data[,block:= (yday(DTM) -1 )%/% 7] # creating a block from each 7 days
model_data[block == 52, block := 51] # last two days not enough to be a proper block so consider it as previous block
stat_model_controlled <- model_data[year(DTM) %in% c(1971:2000),.(q60_c = quantile(pr_5,.6),q90_c=quantile(pr_5,.9)),by=block]
stat_model_future <- model_data[year(DTM) %in% c(2070:2099),.(q60_f = quantile(pr_5,.6),q90_f=quantile(pr_5,.9)),by=block]

# creating a comprehensive dt of stats
stats <- stat_o[stat_model_controlled,on="block"][stat_model_future,on="block"]

# calculate the mean exceedances
E_c = model_data[year(DTM) %in% c(1971:2000)]
E_c[, q90 := quantile(pr, .9), by = block]
E_c = E_c[pr > q90, .(e_c = mean(pr - q90)), by = block]

E_f = model_data[year(DTM) %in% c(2070:2099)]
E_f[, q90 := quantile(pr, .9), by = block]
E_f = E_f[pr > q90, .(e_f = mean(pr - q90)), by = block]

# creating a comprehensive dt of stats + E_c + E_f
stats = stats[E_c,on="block"][E_f,on="block"][order(block)]

# calculate temperature parameters
tem_obs = observed_data[year(DTM) %in% c(1971:2000), .(mean_tem_o = mean(tem_o)), by = block]
tem_control = model_data[year(DTM) %in% c(1971:2000), .(mean_tem_cont= mean(tem), sdt_c = sd(tem)), by = block]
tem_future = model_data[year(DTM) %in% c(2070:2099), .(mean_tem_futr = mean(tem), sdt_f = sd(tem)), by = block]

# creating a comprehensive dt of stats + tem parameter
statics = stats[tem_obs, on="block"][tem_control, on="block"][tem_future, on="block"]

statics = statics[,.(block,q60_o ,q90_o, q60_c , q90_c , q60_f ,q90_f, e_c ,e_f,mean_tem_o, mean_tem_cont ,sdt_c ,mean_tem_futr,sdt_f )]





#             |||| ***** turn the data to a download able format
#                             (.rda) in data directory ***** ||||
usethis::use_data(pr_raster,compress = "xz", overwrite = TRUE)
usethis::use_data(tem_raster,compress = "xz", overwrite = TRUE)
usethis::use_data(observed_data, compress = "xz", overwrite = TRUE)
usethis::use_data(station, compress = "xz", overwrite = TRUE)
usethis::use_data(model_data,compress = "xz", overwrite = TRUE)
usethis::use_data(statics,compress = "xz", overwrite = TRUE)

