#' Get the info about a faculty object
#'
#' @param faculty_ref a reference ID for a faculty
#'
#' @return A character
#' @export
#'
#' @examples
#' add_faculty_info("84190")
add_faculty_info <- function(faculty_ref) {
  res <- get_object_info(faculty_ref) |>
    httr::content()

  faculty_name <- res$object$title

  faculty_name
}
