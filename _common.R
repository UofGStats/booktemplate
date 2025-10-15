# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
)

library(htmltools)
# This code is designed to work with PlanetEStream -- it will use the PlanetEStream player via an iFrame embed.

Planetvid <- function(title) {
  tags$div(class="video-container",
           tags$iframe(allow="autoplay; fullscreen",
                       width="500",
                       height="270",
                       src=title,
                       frameborder="0")
  )
}

#This is how I embed Numbas quiz elements
numbaselement <- function(questionPath, iwidth, iheight) {
  tags$div(class="NQ",
           tags$iframe(
             width=iwidth, height=iheight, sandbox="allow-same-origin allow-scripts allow-forms",
             src=questionPath,
             tags$p("Your browser does not support iframes.")
           )
  )
}
#Sample call is then:
# {r, include=knitr::is_html_output()} block parameters
# numbaselement("NumbasEmbed/SampleQuestion/index.html", iwidth="90%", iheight="450px")

