# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    https://shiny.posit.co/
# #

# Load shiny library
library(shiny)
library(ggplot2)



# reading from the dataset
data_source =read.csv("Sleep_health_dataset.csv")

# Define UI
ui <- navbarPage("Sleep and Health",
                 
                 # Data visualization
                 tabPanel("Data visualization",
                          sidebarLayout(
                            sidebarPanel(
                              h4("Welcome to Sleep and Health Data Analysis"),
                              p("this data visualization is about how our heart rate and BMI relate to our quality of sleep")
                            ),
                            mainPanel(
                              plotOutput("homePlot")
                            )
                          )
                 ),
                 
                 # the dataset view
                 tabPanel("Dataset",
                          sidebarLayout(
                            sidebarPanel(
                              # h4("Data Summary"),
                              # verbatimTextOutput("dataSummary")
                            ),
                            mainPanel(
                              tableOutput("dataTable")
                            )
                          )
                 )
                 
                 # Third tab: About
                 # tabPanel("About",
                 #          mainPanel(
                 #            h4("About this App"),
                 #            p("This app demonstrates how to create a navigation bar in Shiny.")
                 #          )
                 # )
)

# Define server logic 
server <- function(input, output) {
  
#rendering for the visualization
  output$homePlot <- renderPlot(
    # hist(rnorm(100), main = "Histogram of Random Normal Values", xlab = "Values", col = "blue")
    ggplot(data_source, aes(y=Heart.Rate, x= Quality.of.Sleep, color=BMI.Category))+
      geom_line(size=1.5, position = "identity")+
      geom_point(alpha=0.7)+
      theme_minimal()
  )
  
#rendering for the dataset table
  output$dataTable <- renderTable(data_source, options = list(scrollX = TRUE))
}

# Run the application 
shinyApp(ui = ui, server = server)

