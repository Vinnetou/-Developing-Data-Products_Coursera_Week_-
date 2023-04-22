

library(shiny)

# Define UI for the app
ui <- fluidPage(
    
    # Title of the app
    titlePanel("Marathon Pace & Speed Calculator"),
    
    # Sidebar with input controls
    sidebarLayout(
        sidebarPanel(
            helpText("Enter your desired marathon time and select your preferred unit of measurement. The app will calculate your required pace and speed. Marathon is 42.195 kilometers or 26.2188 miles"),
            numericInput("time", "Marathon Time (in minutes):", value = 240),
            selectInput("unit", "Units:", choices = c("km/h", "m/h"), selected = "km/h")
        ),
        
        # Main panel with output
        mainPanel(
            h3("Required Pace"),
            verbatimTextOutput("pace_per_km_or_mile"),
            h3("Required Speed"),
            verbatimTextOutput("speed")
        )
    )
)