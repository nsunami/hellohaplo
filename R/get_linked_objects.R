#' Get linked objects
#'
#' @param obj_ref Reference ID for the object
#' @param sources Haplo API source 
#' @param key Haplo API Key
#'
#' @return A vector of ref IDs linked to the input object 
#' @export
#'
#' @examples
#' get_linked_objects("84190")
get_linked_objects <- function(obj_ref, sources = "NONE", key) {
  run_query <- function(obj_ref, start = 0) {
    GET(paste0("https://ethicsmonitor.eur.nl/api/v0-object/linked/", obj_ref),
      authenticate("haplo", key),
      query = list(
        sources = sources,
        start = start
      )
    ) |>
      content("text") |>
      fromJSON()
  }

  # First run
  res <- run_query(obj_ref)

  if (!is.null(res$results$more)) {
    # Create the initial vector
    refs <- as.vector(res$refs)

    # Loop when there are more results
    while (res$results$more) {
      res <- run_query(obj_ref, start = res$results$end)
      new_data <- as.vector(res$refs)
      # bind to the df
      refs <- refs |>
        append(new_data)
    }
  }
  refs
}