library(shiny)
library(rhessysR)

#happy = readin_rhessys_output("data/patch_sim")


ui <- fluidPage(
  headerPanel('RHESSys Basin Output'),
  sidebarPanel(
    selectInput('var1', 'X Axis', names(happy$bd), selected = names(happy$bd)[79]),
    selectInput('var2', 'Y Axis', names(happy$bd), selected = names(happy$bd)[19])
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function(input, output) {
  selectedData <- reactive({
    happy$bd[, c(input$var1, input$var2)]
  })
  
  output$plot1 <- renderPlot({
    plot(selectedData())
  })
}

shinyApp(ui = ui, server = server)


