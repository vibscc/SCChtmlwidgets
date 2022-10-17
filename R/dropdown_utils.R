#' Add an option to a dropdown widget
#'
#' @param dropdown The dropdown widget
#' @param name Name of the option to add
#' @param p ggplot to add with this name
#'
#' @export
addDropdownOption <- function(dropdown, name, p) {
  dropdown$x$data[[name]] <- ggplot_to_svg(p)

  return(dropdown)
}

#' Remove an option from a dropdown widget
#'
#' @param dropdown The dropdown widget
#' @param name Name of the option to add
#'
#' @export
removeDropdownOption <- function(dropdown, name) {
  if (name %in% names(dropdown$x$data)) {
    dropdown$x$data[[name]] <- NULL
  }

  return(dropdown)
}
