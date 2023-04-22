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

# Define server logic
server <- function(input, output) {
    
    # Calculate the pace based on the input
    pace <- reactive({
        time_sec <- input$time * 60
        if (input$unit == "km/h") {
            pace_km <- time_sec / 42.195
            pace_km
        } else {
            pace_m <- time_sec / 26.2188
            pace_m
        }
    })
    
    # Calculate the pace per kilometer or mile based on the input
    pace_per_km_or_mile <- reactive({
        if (input$unit == "km/h") {
            pace_km_per_min <- pace() / 60
            pace_km_per_min
        } else {
            pace_m_per_min <- pace() / 60 #/  1.60934
            pace_m_per_min
        }
    })
    
    # Calculate the speed in km/h or m/h based on the input
    speed <- reactive({
        if (input$unit == "km/h") {
            60 / pace_per_km_or_mile()
        } else {
            60 / pace_per_km_or_mile() #/ 1.60934
        }
    })
    
    
    # # Input
    # fraction_of_minute <- 5.69
    # 
    # # Convert fraction of minute to minutes and seconds
    # seconds_ <- round(fraction_of_minute * 60)
    # minutes <- floor(seconds_ / 60)
    # seconds <- seconds_ %% 60
    # 
    # # Output
    # paste0(minutes, " minutes and ", seconds, " seconds")
    
    
    # Output the calculated pace per km or mile
    output$pace_per_km_or_mile <- renderText({
        if (input$unit == "km/h") {
            #pace_per_km <- round(1 / pace_per_km_or_mile() * 60, 2)
            fraction_of_minute <- round(pace_per_km_or_mile(), 2)
            # Convert fraction of minute to minutes and seconds
            seconds_ <- round(fraction_of_minute * 60)
            minutes <- floor(seconds_ / 60)
            seconds <- seconds_ %% 60
            pace_tidy <- paste0(minutes, " minutes and ", seconds, " seconds")
            paste0(pace_tidy, " per kilometer.")
        } else {
            #pace_per_mile <- round(1 / pace_per_km_or_mile() * 60, 2)
            fraction_of_minute <- round(pace_per_km_or_mile(), 2)
            # Convert fraction of minute to minutes and seconds
            seconds_ <- round(fraction_of_minute * 60)
            minutes <- floor(seconds_ / 60)
            seconds <- seconds_ %% 60
            pace_tidy <- paste0(minutes, " minutes and ", seconds, " seconds")
            paste0(pace_tidy, " per mile.")
        }
    })
    
    
    # Output the calculated speed in km/h or m/h
    output$speed <- renderText({
        if (input$unit == "km/h") {
            paste0(round(speed(), 2), " km/h")
        } else {
            paste0(round(speed(), 2), " m/h")
        }
    })
}

# Run the app
shinyApp(ui = ui, server = server)
