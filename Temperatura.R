############################################
## Collect in real time cities' temperature
## accessing INEP web page
#############################################
###################
#load library
##################
library(rvest)
##################


# Search city temperature function
##################################

temp_search <- function(city) {
  # Combine URL + City
  url <- "http://www.cptec.inpe.br/cidades/tempo/"
  url_city <- paste(url, city, sep = "")
  #Read city data
  info <- read_html(url_city)
  # Mount string
  city <- info %>%
    html_nodes(".i") %>%
    html_text()
  city <- city[1] # only current temperature
  
  temp <- info %>%
    html_nodes(".c2") %>%
    html_text()
  str_temperature <-
    temp[1] # only current temperature
  

  
  ## split string at non-digits
  s <- strsplit(str_temperature, "[^[:digit:]]")
  
  ## convert strings to numeric ("" become NA)
  temperature <- as.numeric(unlist(s))
  
  ## remove NA and duplicates
  temperature <- unique(temperature[!is.na(temperature)])
  
  print(paste(city, temperature, sep = " -> "))
  
  return()
}



cities <- c(241, 3946)
for (i in cities) {
  temp_search(i)
}
