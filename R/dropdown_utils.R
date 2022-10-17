#' Add an option to a dropdown widget
#'
#' @param dropdown The dropdown widget
#' @param name Name of the option to add
#' @param p ggplot to add with this name
#' @param width Plot width in pixels
#' @param height Plot height in pixels
#' @param img.format Image format to generate. Available options: svg, png
#'
#' @export
addDropdownOption <- function(dropdown, name, p, width = NULL, height = NULL, img.format = c("svg", "png")) {
  img.format <- match.arg(img.format)
  dropdown$x$data[[name]] <- ggplot_to_html(p, width, height, img.format)

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
