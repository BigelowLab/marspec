#' Retrieve the MARSPEC url(s) for one or more datasets identified by name
#' 
#' @export
#' @param name chr one or more MARSPEC data set names.
#'   If name is missing then all are returned.
#' @param stub chr the URI base
#' @return one or moire URLs
marspec_uri = function(name, 
                       stub = "https://www.esapubs.org/archive/ecol"){
  uris = c(
    "MARSPEC_2o5m" = "E094/086/MARSPEC_LowResFiles/MARSPEC_2o5m.7z",
    "MARSPEC_5m" = "E094/086/MARSPEC_LowResFiles/MARSPEC_5m.7z",
    "MARSPEC_10m" = "E094/086/MARSPEC_LowResFiles/MARSPEC_10m.7z",
    "bathymetry_30s" = "E094/086/MARSPEC_HighResFiles/bathymetry_30s.7z",
    "biogeo01_07_30s" = "E094/086/biogeo01_07_30s.7z",
    "biogeo08_17_30s" = "E094/086/biogeo08_17_30s.7z",
    "Sea_Ice_30s" = "E094/086/MARSPEC_HighResFiles/Sea_Ice_30s.7z",
    "Monthly_Variables_30s" = "E094/086/Monthly_Variables_30s.7z",
    "6kya_CCSM" = "E095/149/6kya_CCSM.7z",
    "6kya_CSIRO" = "E095/149/6kya_CSIRO.7z", 
    "6kya_ECBILTCLIOVECODE" = "E095/149/6kya_ECBILTCLIOVECODE.7z", 
    "6kya_FGOALS" = "E095/149/6kya_FGOALS.7z", 
    "6kya_FOAM" = "E095/149/6kya_FOAM.7z", 
    "6kya_MIROC-32" = "E095/149/6kya_MIROC-32.7z", 
    "6kya_MRI-fa" = "E095/149/6kya_MRI-fa.7z", 
    "6kya_MRI-nfa" = "E095/149/6kya_MRI-nfa.7z", 
    "6kya__Ensemble" = "E095/149/6kya__Ensemble.7z", 
    "21kya_CCSM" = "E095/149/21kya_CCSM.7z",
    "21kya_Geophysical_Data" = "E095/149/21kya_Geophysical_Data.7z", 
    "21kya_CNRM" = "E095/149/21kya_CNRM.7z", 
    "21kya_ECBILTCLIO" = "E095/149/21kya_ECBILTCLIO.7z", 
    "21kya_FGOALS" = "E095/149/21kya_FGOALS.7z", 
    "21kya_HadCM" = "E095/149/21kya_HadCM.7z", 
    "21kya_MIROC-322" = "E095/149/21kya_MIROC-322.7z", 
    "21kya__Ensemble_adjCCSM" = "E095/149/21kya__Ensemble_adjCCSM.7z", 
    "21kya__Ensemble_noCCSM" = "E095/149/21kya__Ensemble_noCCSM.7z")
  
  if (missing(name)){
    uri = file.path(stub, unname(uris)) |>
      rlang::set_names(names(uris))
  } else {
    uri = file.path(stub, unname(uris[name])) |>
      rlang::set_names(name)
  }
  uri
}


#' Fetch (and unpack) one or more MARSPEC data sets by name
#' 
#' @export
#' @param name chr, the name of the MARSPEC data set
#' @param path chr, the directory where data is stored
#' @param unpack logical, if TRUE unpack the downloaded data
#' @param cleanup logical, if TRUE and unpack is TRUE then remove the compressed file
#'   after unpacking
#' @return the filename(s) downloaded or unpacked invisibly
fetch_marspec = function(name, 
                         path = marspec_path(),
                         unpack = TRUE,
                         cleanup = TRUE){
  
  uris = marspec_uri(name)
  for (nm in names(uris)){
    ofile = file.path(path, basename(uris[[nm]]))
    ok = download.file(uris[[nm]], ofile)
    if (unpack){
      ff = archive::archive_extract(ofile, path)
      if (cleanup) ok = file.remove(ofile)
      ofile = ff
    }    
  }
  
  return(invisible(ofile))
}

