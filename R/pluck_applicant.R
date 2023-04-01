#' Pluck a vector of researcher refs from an API response
#'
#' @param res_content A response content object 
#'
#' @return A vector
#' @export
#'
#' @examples
#' # Get an application 8435x
#' application <- get_object_info("8435x") |>
#'   get_content()
#' pluck_applicant(application)
#' 
pluck_applicant <- function(res_content) {
  res_content[["object"]][["attributes"]][["hres:attribute:researcher"]][["ref"]]
}
