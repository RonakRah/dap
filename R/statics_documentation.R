#' @title  statics
#' @description showing statistical information such as quantile and mean exceedance for each blocks than uncludes 7 days
#' @format a data table with 14 columns and 52 rows  that includes:
#' \describe{
#'   \item{block}{each 7 days became a block }
#'   \item{q60_o}{ 60% quantile of observation data }
#'   \item{q90_o}{90% quantile of observation data }
#'   \item{q60_c}{60% quantile of controlled data }
#'   \item{q90_c}{90% quantile of controlled data }
#'   \item{q60_f}{60% quantile of future data }
#'   \item{q90_f}{90% quantile of future data }
#'   \item{e_c}{ mean exceedance of controlled data}
#'   \item{e_f}{ mean exceedance of future data}
#'   \item{mean_tem_o}{ mean observation temprature of each  block}
#'   \item{mean_tem_cont}{ mean controlled temprature of each block}
#'   \item{mean_tem_futr}{ mean future temprature of each block}
#'   \item{sdt_c}{ standard diviation of temprature for controll time for each block}
#'   \item{sdt_f}{ standard diviation of temprature for future time for each block}
#'   \item{i.mean_tem_o}{ mean exceedance of future data}
#'}
"statics"
