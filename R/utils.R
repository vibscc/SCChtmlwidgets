#' Convert a ggplot2 plot to an SVG string
#'
#' @param p ggplot2 plot
#'
#' @importFrom gridSVG grid.export
#' @importFrom XML saveXML

ggplot_to_svg <- function(p) {
  if (!inherits(p, c("ggplot","ggmultiplot"))) {
    stop("Plot should be created with ggplot2", call. = F)
  }

  print(p)
  svg <- grid.export(name = NULL)$svg

  if (!inherits(svg, c("XMLAbstractDocument","XMLAbstractNode"))) {
    stop("Something went wrong converting ggplot to svg")
  }

  return(saveXML(svg))
}
