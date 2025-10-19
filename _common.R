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

#This is how I embed Numbas quiz elements, old version
oldnumbaselement <- function(questionPath, iwidth, iheight) {
  tags$div(class="NQ",
           tags$iframe(
             width=iwidth, height=iheight, sandbox="allow-same-origin allow-scripts allow-forms",
             src=questionPath,
             tags$p("Your browser does not support iframes.")
           )
  )
}

# New version with HTML/PDF/other conditional display
# Html gets an iframe
# PDF gets either a message that a Q appears here in html, or...
#     if passed a url then it makes a link.
numbaselement <- function(questionPath, iwidth = 600, iheight = 400, url= "") {
  if (knitr::is_html_output()) {
    # HTML output: create a div with iframe
    htmltools::tags$div(
      class = "NQ",
      htmltools::tags$iframe(
        width = iwidth,
        height = iheight,
        sandbox = "allow-same-origin allow-scripts allow-forms",
        src = questionPath,
        htmltools::tags$p("Your browser does not support iframes.")
      )
    )
  } else if (knitr::is_latex_output()) {
    # --- PDF output ---
    if (nzchar(url)) {
      # If a URL was provided make a clickable link
      latex_link <- sprintf("\\href{%s}{Link to Numbas question}", url)
      knitr::asis_output(latex_link)
    } else {
      # No URL → simple note
      knitr::asis_output("A Numbas question appears here in the HTML version.")
    }
    
  } else {
    # --- Fallback for other formats (e.g. Word) ---
    if (nzchar(url)) {
      md <- sprintf("[Link to Numbas question](%s)", url)
    } else {
      md <- "A Numbas question appears here in the HTML version."
    }
    knitr::asis_output(md)
  }
}

#Sample call is then: (optional url to create PDF hyperlink)
# {r, include=knitr::is_html_output()} block parameters
# numbaselement("NumbasEmbed/SampleQuestion/index.html", iwidth="90%", iheight="450px", url="https://www.numb...")
