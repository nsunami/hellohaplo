get_applicants <- function(application_ref) {
  application_info <- application_ref |>
    get_object_info(sources = "std:username") |>
    httr::content("text") |>
    jsonlite::fromJSON()
  
  # Vector of applicants
  application_info[["object"]][["attributes"]][["hres:attribute:researcher"]][["ref"]]
}
