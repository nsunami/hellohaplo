#' Get linked objects
#'
#' @param obj_ref Reference ID for the object
#' @param sources Haplo API source
#' @param key Haplo API Key
#' @param base_URL The URL of the Haplo app
#'
#' @return A vector of ref IDs linked to the input object
#' @export
#'
#' @examples
#' get_linked_objects("84190")
get_linked_objects <- function(obj_ref, sources = "NONE",
                               key = Sys.getenv("HAPLO_API_KEY"),
                               base_URL = Sys.getenv("HAPLO_BASE_URL")) {
  run_query <- function(obj_ref, start = 0) {
    httr::GET(
      paste0(base_URL, "/api/v0-object/linked/", obj_ref),
      httr::authenticate("haplo", key),
      query = list(
        sources = sources,
        start = start
      )
    ) |>
      httr::content("text") |>
      jsonlite::fromJSON()
  }

  # First run
  res <- run_query(obj_ref)

  if (!is.null(res$results$more)) {
    # Create the initial vector
    refs <- as.vector(res$refs)

    # Loop when there are more results
    while (res$results$more) {
      res <- run_query(obj_ref,
        start = res$results$end)
      new_data <- as.vector(res$refs)
      # bind to the df
      refs <- refs |>
        append(new_data)
    }
  }
  refs
}
