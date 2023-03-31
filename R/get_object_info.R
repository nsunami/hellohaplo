get_object_info <- function(ref, sources = "ALL",
                            key = Sys.getenv("HAPLO_API_KEY")) {
  httr::GET(paste0("https://ethicsmonitor.eur.nl/api/v0-object/ref/", ref),
    httr::authenticate("haplo", key),
    query = list(sources = sources)
  )
}
