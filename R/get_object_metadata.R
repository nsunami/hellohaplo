get_object_metadata <- function(example_ref) {
  # Sleep for random seconds
  sleep_time <- stats::runif(1, min = 0.01, max = 0.05)
  Sys.sleep(sleep_time)
  
  object_info <- get_object_info(example_ref) |>
    httr::content()
  # Select the workflow that has workType "hres_ethics:eth"
  ethics_workflow <- object_info$object$workflows |>
    purrr::map(function(workflow) {
      workflow[workflow$workType == "hres_ethics:eth"]
    }) |>
    unlist(recursive = FALSE)
  
  # Figure out if the auto-approval was made - this was not accurate and thus removing this
  # Applications such as https://ethicsmonitor.eur.nl/842y4 was marked as automatically approved
  auto_approve_consent <- ethics_workflow[["documents"]][["form"]][["consentToAutoApproval"]] |>
    list()
  
  # Data management plan there or not?
  # Coercing to a character since some application (8228q) had a logical value (FALSE) there
  with_DMP <- ethics_workflow[["documents"]][["form"]]$alreadyHaveADataManagementPlan |>
    as.character()
  
  # Get related application, if any
  related_app <- object_info$object$attributes$`hres:attribute:related-application`[[1]]$ref |>
    list()
  
  # Return tibble
  dplyr::tibble(
    created_by = ethics_workflow[["documents"]][["form"]][["principalInvestigator"]],
    created_at = ethics_workflow$createdAt,
    opened_at = ethics_workflow$openedAt,
    closed = ethics_workflow$closed,
    state = ethics_workflow$state,
    with_DMP = with_DMP,
    related_app = related_app,
    auto_approve_consent = auto_approve_consent,
  )
}
