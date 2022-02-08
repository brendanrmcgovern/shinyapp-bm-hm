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
                               "The Tahoe-Central Sierra region is a diverse landscape that covers approximately 2.4 million acres of land, multiple National Forests, Wildernesses, cities and cities. The region is rich in diversity, but under threat from climate change impacts. This study sought to determine specific stakeholder interest in various ecosystem services to better prioritize how to protect these services under changing climate and future management scenarios...
                               OUTPUT MAP GOES HERE with a description of how participants were asked to identify regions of interest within our study region
                               NEED TO FIGURE OUT HOW TO INSERT MAP AND PLOT SHAPEFILES OF STUDY REGION HERE",
                               plotOutput("sw_plot")
                             ) #end of mainPanel
                          ) #end of sidebarLayout
                          ), #end of tabPanel thing 1
    tabPanel("Impacts/Risks to ecosystem services"),
    tabPanel("Threats to ecosystem services"),
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
