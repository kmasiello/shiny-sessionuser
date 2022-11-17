
library(shiny)

ui <- fluidPage(

    titlePanel("Hello World with `session$user`"),

    sidebarLayout(
        sidebarPanel(
          h3("User Information"),
          "User name: ", verbatimTextOutput("user_name"),
          "User groups: ", verbatimTextOutput("user_group"),
        ),

        mainPanel(
          tags$b("Shiny server code"),
          verbatimTextOutput("server_code"),
          br(),
          tags$b("Shiny UI code"),
          verbatimTextOutput("ui_code"),
          tags$b("Run the app"),
          verbatimTextOutput("runapp")
          
           )
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # defaults
  session_user_name <- "unknown user"
  session_user_groups <- "unknown groups"
  
  # change defaults if a user exists
  if (!is.null(session$user)) {
    session_user_name <- session$user
    session_user_groups <- session$groups
  }
  
  output$user_name <- renderText({
    session_user_name
  })
      
  output$user_group <- renderText({
    session_user_groups
  })
  
  
  output$ui_code <- renderText("
   ui <- fluidPage(
     titlePanel(\"Hello World with `session$user`\"),
     sidebarLayout(
       sidebarPanel(
        h3(\"User Information\"),
        \"User name: \", verbatimTextOutput(\"user_name\"),
        \"User groups: \", verbatimTextOutput(\"user_group\"),
        ),
  
       mainPanel(
         tags$b(\"Shiny server code\"),
         verbatimTextOutput(\"server_code\"),
         br(),
         tags$b(\"Shiny UI code\"),
         verbatimTextOutput(\"ui_code\"),
         tags$b(\"Run the app\"),
         verbatimTextOutput(\"runapp\")
        )
    )
  )
  ")
  
  output$server_code <- renderText("
server <- function(input, output, session) {
  
  # defaults
  session_user_name <- \"unknown user\"
  session_user_groups <- \"unknown groups\"
  
  # change defaults if a user exists
  if (!is.null(session$user)) {
    session_user_name <- session$user
    session_user_groups <- session$groups
  }
  
  output$user_name <- renderText({
    session_user_name
  })
      
  output$user_group <- renderText({
    session_user_groups
  })
}
  ")
  
output$runapp <- renderText("shinyApp(ui = ui, server = server)")
    
}




# Run the application 
shinyApp(ui = ui, server = server)
