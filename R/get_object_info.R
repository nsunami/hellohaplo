#' Get the information about a given object with a ref
#'
#' @param ref A ref of a stored object
#' @param sources Sources parameter 
#' @param key API Key
#'
#' @return A httr response object
#' @export
#'
#' @examples
#' get_object_info("84190")
get_object_info <- function(ref, sources = "ALL",
                            key = Sys.getenv("HAPLO_API_KEY")) {
  httr::GET(paste0("https://ethicsmonitor.eur.nl/api/v0-object/ref/", ref),
    httr::authenticate("haplo", key),
    query = list(sources = sources)
  )
}