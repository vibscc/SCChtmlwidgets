#' Convert a ggplot object to an html tag
#'
#' @param p ggplot2 plot
#' @param width Plot width in pixels
#' @param height Plot height in pixels
#' @param img.format Image format to generate. Available options: svg, png
ggplot_to_html <- function(p, width = NULL, height = NULL, img.format = c("svg", "png")) {
  img.format <- match.arg(img.format)

  if (!inherits(p, c("ggplot","ggmultiplot"))) {
    stop("Plot should be created with ggplot2", call. = F)
  }

  if (img.format == "svg") {
    return(ggplot_to_svg(p))
  } else {
    return(ggplot_to_img_png(p, width, height))
  }
}

#' Convert a ggplot2 plot to an SVG string
#'
#' @param p ggplot2 plot
#'
#' @importFrom gridSVG grid.export
#' @importFrom XML saveXML
ggplot_to_svg <- function(p) {
  print(p)
  svg <- grid.export(name = NULL)$svg

  if (!inherits(svg, c("XMLAbstractDocument","XMLAbstractNode"))) {
    stop("Something went wrong converting ggplot to svg")
  }

  return(saveXML(svg))
}

#' Convert a ggplot2 plot to a base64 encoded png
#'
#' @param p ggplot2 plot
#' @param width Plot width in pixels.
#' @param height Plot height in pixels.
#'
#' @importFrom ggplot2 ggsave
#' @importFrom base64enc base64encode
ggplot_to_img_png <- function(p, width = NULL, height = NULL) {
  tmp.file <- tempfile()

  dimensions <- get_dimensions(width, height)

  ggsave(
    tmp.file,
    p,
    device = "png",
    width = dimensions$width,
    height = dimensions$height,
    units = "px"
  )

  data.binary <- readBin(tmp.file, raw(), file.info(tmp.file)$size)
  base64.string <- base64encode(data.binary)

  file.remove(tmp.file)

  return(sprintf('<img src="data:image/png;base64,%s" />', base64.string))
}

#' Calculate dimensions for a plot
#'
#' @param width Plot width in pixels.
#' @param height Plot height in pixels.
#' @param aspect.ratio Plot aspect ratio
get_dimensions <- function(width = NULL, height = NULL, aspect.ratio = 16/9) {
  if (is.null(width) && is.null(height)) {
    width <- 1920
    height <- 1080
  } else if (is.null(width)) {
    width <- height * aspect.ratio
  } else if (is.null(height)) {
    height <- width / aspect.ratio
  }

  return(list(
    width = width,
    height = height
  ))
}
