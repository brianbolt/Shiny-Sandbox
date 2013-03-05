library(shiny)
library(shiny)
library(RJSONIO)

jsonToList <- function(json) {
  jsonAsList <- fromJSON(json, nullValue = NA)
	return(jsonAsList)
}
jsonToDataFrame <- function(json) {
	jsonAsList <- jsonToList(json)
	f <- function(jsonList) function(nm) unlist(lapply(jsonList, "[[", nm), use.names=FALSE) 
	jsonAsDataFrame <- as.data.frame(Map(f(jsonAsList), names(jsonAsList[[1]]))) 
	return(jsonAsDataFrame)
}

# Minimal Custom
shinyServer(function(input, output) {
  
  table_data <- reactive({
    input$exampleGrid
  })
  
  output$table_text <- renderTable({
    jsonToDataFrame(table_data())
  })
  
})
