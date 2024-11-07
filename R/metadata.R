#' Retrieve the MARSPEC metadata table
#'
#' @export
#' @return a tibble of metadata
marspec_metadata = function(){
  structure(list(Layer.Name = c("bathymetry", "biogeo01", "biogeo02", 
                                "biogeo03", "biogeo04", "biogeo05", "biogeo06", "biogeo07", "biogeo08", 
                                "biogeo09", "biogeo10", "biogeo11", "biogeo12", "biogeo13", "biogeo14", 
                                "biogeo15", "biogeo16", "biogeo17", "sss01", "sss02", "sss03", 
                                "sss04", "sss05", "sss06", "sss07", "sss08", "sss09", "sss10", 
                                "sss11", "sss12", "sst01", "sst02", "sst03", "sst04", "sst05", 
                                "sst06", "sst07", "sst08", "sst09", "sst10", "sst11", "sst12"  ), 
                 Layer.Definition = c("depth of the seafloor", "East/West Aspect (sin(aspect in radians))", 
                                      "North/South Aspect (cos(aspect in radians))", "Plan Curvature", 
                                      "Profile Curvature", "Distance to Shore", "Bathymetric Slope", 
                                      "Concavity", "Mean Annual SSS", "Minimum Monthly SSS", "Maximum Monthly SSS", 
                                      "Annual Range in SSS", "Annual Variance in SSS", "Mean Annual SST", 
                                      "SST of the coldest ice-free month", "SST of the warmest ice-free month", 
                                      "Annual Range in SST", "Annual Variance in SST", "mean January SSS", 
                                      "mean February SSS", "mean March SSS", "mean April SSS", "mean May SSS", 
                                      "mean June SSS", "mean July SSS", "mean August SSS", "mean September SSS", 
                                      "mean October SSS", "mean November SSS", "mean December SSS", 
                                      "mean January SST", "mean February SST", "mean March SST", "mean April SST", 
                                      "mean May SST", "mean June SST", "mean July SST", "mean August SST", 
                                      "mean September SST", "mean October SST", "mean November SST", 
                                      "mean December SST"), 
                 Units = c("meters", "radians", "radians", 
                           "none", "none", "kilometers", "degrees", "degrees", "psu", "psu", 
                           "psu", "psu", "psu", "degrees C", "degrees C", "degrees C", "degrees C", 
                           "degrees C", "psu", "psu", "psu", "psu", "psu", "psu", "psu", 
                           "psu", "psu", "psu", "psu", "psu", "degrees C", "degrees C", 
                           "degrees C", "degrees C", "degrees C", "degrees C", "degrees C", 
                           "degrees C", "degrees C", "degrees C", "degrees C", "degrees C"
                 ), 
                 Scaling.Factor = c(1, 100, 100, 10000, 10000, 1, 10, 1000, 
                                    100, 100, 100, 100, 10000, 100, 100, 100, 100, 10000, 100, 100, 
                                    100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 
                                    100, 100, 100, 100, 100, 100, 100, 100, 100), 
                 Derived.from = c("SRTM30_Plus Bathymetry", 
                                  "Bathymetry", "Bathymetry", "Bathymetry", "Bathymetry", "GSHHS Coastline", 
                                  "Bathymetry", "Bathymetry", "SSS monthly climatologies", "SSS monthly climatologies", 
                                  "SSS monthly climatologies", "SSS monthly climatologies", "SSS monthly climatologies", 
                                  "SST monthly climatologies", "SST monthly climatologies", "SST monthly climatologies", 
                                  "SST monthly climatologies", "SST monthly climatologies", "WOA09", 
                                  "WOA09", "WOA09", "WOA09", "WOA09", "WOA09", "WOA09", "WOA09", 
                                  "WOA09", "WOA09", "WOA09", "WOA09", "Aqua MODIS", "Aqua MODIS", 
                                  "Aqua MODIS", "Aqua MODIS", "Aqua MODIS", "Aqua MODIS", "Aqua MODIS", 
                                  "Aqua MODIS", "Aqua MODIS", "Aqua MODIS", "Aqua MODIS", "Aqua MODIS"
                 )), row.names = c(NA, -42L), class = "data.frame") |>
    dplyr::as_tibble()
}


#' Retrieve the scaling factor for one or more datasets matched by name
#' 
#' @export
#' @param name chr, one or more data layer names
#' @param meta table of metadata
#' @return named numeric scaling factor
get_scaling = function(name = c("bathy_10m", "biogeo13_2o5m"),
                       meta = marspec_metadata()){
  short = sapply(strsplit(name, "_", fixed = TRUE), "[[", 1)
  sapply(short,
         function(shortname){
           dplyr::filter(meta, grepl(shortname, .data$Layer.Name, fixed = TRUE)) |>
             dplyr::pull(Scaling.Factor)
         }) |>
    rlang::set_names(name)
}