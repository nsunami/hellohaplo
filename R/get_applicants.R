#' Get the vector of applicants for the given ethics application
#'
#' @param application_ref A object ref
#'
#' @return A character vector of refs
#' @export 
#'
#' @examples
#' application <- get_applicants("8435x")
get_applicants <- function(application_ref) {
  application_info <- application_ref |>
    get_object_info(sources = "std:username") |>
    httr::content("text") |>
    jsonlite::fromJSON()
  
  # Vector of applicants
  as.vector(
    application_info[["object"]][["attributes"]][["hres:attribute:researcher"]][["ref"]]
  )
}
