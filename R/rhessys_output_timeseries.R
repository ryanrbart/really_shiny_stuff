library(shiny)
library(rhessysR)

#happy = readin_rhessys_output("data/patch_sim")


ui <- fluidPage(
  headerPanel('RHESSys Basin Output'),
  sidebarPanel(
    selectInput('var1', 'Variable 1', names(happy$bd), selected = names(happy$bd)[19]),
    sliderInput(
      inputId = "date_range", 
      label = "Choose Date Range:", 
      value = c(happy$bd$date[1], max = happy$bd$date[length(happy$bd$date)]),
      min = happy$bd$date[1], 
      max = happy$bd$date[length(happy$bd$date)]
      ),
    radioButtons("ylog", "Log Y Axis?", c("Log" = "y", "No log" = ""))
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function(input, output) {
  selectedData <- reactive({
    happy$bd[, c("date", input$var1)]     # Subset date column and column of interest
  })

  output$plot1 <- renderPlot({
    plot(selectedData(), xlim = input$date_range, log = input$ylog)
  })
}

shinyApp(ui = ui, server = server)








