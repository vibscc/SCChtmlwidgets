#' Create an interactive dropdown
#'
#' @param data List of options and corresponding ggplot
#' @param width Width in pixels (optional, defaults to automatic sizing)
#' @param height Height in pixels (optional, defaults to automatic sizing)
#'
#' @import htmlwidgets
#'
#' @export
dropdown <- function(data = list(), width = NULL, height = NULL) {
  data <- lapply(data, ggplot_to_svg)

  htmlwidgets::createWidget(
    name = 'dropdown',
    x = list(data = data),
    width = width,
    height = height,
    package = 'SCCWidgets'
  )
}

#' Shiny bindings for dropdown
#'
#' Output and render functions for using dropdown within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a dropdown
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name dropdown-shiny
#'
#' @export
dropdownOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'dropdown', width, height, package = 'SCCWidgets')
}

#' @rdname dropdown-shiny
#' @export
renderdropdown <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, dropdownOutput, env, quoted = TRUE)
}
