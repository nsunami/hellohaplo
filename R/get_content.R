#' A helper function to create a list from a response content
#'
#' @param res An httr response object 
#'
#' @return A list
#' @export
#'
#' @examples
#' get_object_info("8435x") |>
#'   get_content()
get_content <- function(res) {
  res |>
    httr::content(type = "text") |>
    jsonlite::fromJSON()
}
