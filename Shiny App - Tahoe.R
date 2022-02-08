# attach packages
library(shiny)
library(tidyverse)


# create the user interface
ui <- fluidPage(theme = "tahoe.css",
                navbarPage(
                  "Visualizing Ecosystem Services of Interest in the Tahoe-Central Sierra Region - Blue Forest Conservation",
                  tabPanel("Ecosystem benefits",
                           sidebarLayout(
                             sidebarPanel(
                               "WIDGETS GO HERE",
                               checkboxGroupInput(inputId = "pick_species",
                                                  label = "Choose species:",
                                                  choices = unique(starwars$species)
                                                  ) # end checkboxGroupInput
                             ), #end of sidebarPanel
                              mainPanel(
                               "OUTPUT MAP GOES HERE",
                               plotOutput("sw_plot")
                             ) #end of mainPanel
                          ) #end of sidebarLayout
                          ), #end of tabPanel thing 1
    tabPanel("Risks to ecosystem services"),
    tabPanel("Priority Management Areas")
  ) #end of navbarPage
) #end ui


# create server function
server <- function(input, output) {
  sw_reactive <- reactive({
    starwars %>% 
      filter(species %in% input$pick_species)
  }) # end sw_reactive
  
  output$sw_plot <- renderPlot(
    ggplot(data = sw_reactive(), aes(x = mass, y = height)) +
      geom_point(aes(color = species))
    ) #end output$plot
}

# combine into an app:

shinyApp(ui = ui, server = server)
