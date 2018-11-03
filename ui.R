library(shiny)
library(shinythemes)
library(shinycssloaders)
library(readr)
library(tidyverse)
library(Rmisc)
library(tools)


fluidPage(
  theme = shinytheme("sandstone"),
  title = "Temperature dataloggers",
  plotOutput("contents1") %>% withSpinner(type = getOption("spinner.type", default = 4)), 
  textOutput("contents2") %>% withSpinner(type = getOption("spinner.type", default = 4)), 
  hr(),
  fluidRow(
    column(3,
           h3("Temperature dataloggers"),
           h4("1."),
           fileInput('csv_data', 
                     'Upload csv file',
                     accept = c('sheetName', 'header'), 
                     multiple = FALSE),
           p(a("GitHub", href = "https://github.com/Vojczech/TMS_visualization", target="_blank"))
    ),
    column(4, 
           h4("2."),
           offset = 1,
           textInput("plot_title", 'Write plot title',
                     placeholder = "e.g. probe serial no. 93164188"),
           dateRangeInput('date_range',
                          label = 'Filter by date',
                          start = Sys.Date() - 3, end = Sys.Date() + 3,
                          separator = " to ", format = "yy/mm/dd",
                          startview = 'month', language = 'en', weekstart = 1
           ),
           radioButtons("x_scale", "Label X axis by:", 
                        c("day", "week", "month", "year"), 
                        inline = TRUE,
                        selected = "week")
    ),
    column(4,
           h4("3."),
           checkboxGroupInput("plot_type", label = h3("Choose CO2 concetration"), 
                              choices = list("Soil" = "soil", "Atmospheric" = "atmospheric"),
                              selected = c("soil", "atmospheric")),
           uiOutput("ui"),
           br(),
           downloadButton("download_plot", 
                          "Download final plot")
    )
  )
)