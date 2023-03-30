get_object_info <- function(ref, sources = "ALL") {
  httr::GET(paste0("https://ethicsmonitor.eur.nl/api/v0-object/ref/", ref),
    authenticate("haplo", key),
    query = list(sources = sources)
  )
}
