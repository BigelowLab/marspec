

#' List available MARSPEC rasters
#' 
#' @export
#' @param path chr, the root path to the local MARSPEC data holdings
#' @return chr, a named vector of paths
list_marspec = function(path = marspec_path()){
  ff = list.files(path, recursive = TRUE, full.names = TRUE,
             pattern = "metadata\\.xml") |>
    dirname()
  names(ff) <- basename(ff)
  ff
}

#' Read one or more MARSPEC rasters
#' 
#' @export
#' @param name chr the name of the marspec file to read
#' @param form chr one of "SpatRaster" or "stars" (the default)
#' @param meta table of marspec metadata
#' @param ... other arguments for [`list_marspec()`]
#' @return either a SpatRaster or stars object
read_marspec = function(name = "bathy_10m",
                        form = c("SpatRaster", "stars")[2],
                        meta = marspec_metadata(),
                        ...){
  
  ff = list_marspec(...)[name[1]]
  scaling = get_scaling(names(ff), meta = meta)
  if (tolower(form[1]) == "stars"){
    x = stars::read_stars(ff, along = NA_integer) |>
      rlang::set_names(name)
    x[[1]] = x[[1]]/scaling
  } else {
    x = terra::rast(ff)
    x = x/scaling
  }
  x
}
