#packages

library("lsa")
library("tm")
library("forcats")
library("stringr")
library("tidytext")
library("dplyr")
library("shiny")
library("tidyverse")
library("ggplot2")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("psych")
library("data.table")
library("DataExplorer")



#load data from Homepage and save


#wine_ratings_original <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-28/winemag-data-130k-v2.csv")

#write.csv2(wine_ratings_original, file = "wine_ratings_original.csv", fileEncoding = "UTF-8", sep = ";", row.names = FALSE)



#load data from original csv


wine_ratings <- read.csv(file ="wine_ratings_original.csv", header=TRUE, sep=";", encoding = "UTF-8")





# Erstellen einer Spalte im Haupt-Dataframe mit Geschlecht der Taster --- 

#Identifizierung der verschiedenen Taster

data.frame(unique(wine_ratings$taster_name)) -> tasters
na.omit(tasters) ->tasters 

#Erstellen eines eigenen Dateframes mit Name und Geschlecht der Taster

taster_name <- c("Kerin O’Keefe", "Roger Voss", "Paul Gregutt", "Alexander Peartree", "Michael Schachner",
                 "Anna Lee C. Iijima", "Virginie Boone", "Matt Kettmann", "Sean P. Sullivan", "Jim Gordon",
                 "Joe Czerwinski", "Anne Krebiehl MW", "Lauren Buzzeo", "Mike DeSimone", "Jeff Jenssen", 
                 "Susan Kostrzewa", "Carrie Dykes", "Fiona Adams", "Christina Pickard" )

taster_gender <- c("Female", "Male", "Male", "Male", "Male",
            "Female", "Female", "Male", "Male", "Male",
            "Male", "Female", "Female", "Male", "Male",
            "Female", "Female", "Female", "Female")


taster_names_and_gender <- data.frame(taster_name, taster_gender)


#Hinzufügen der Spalte "gender" zum Haupt-Dataframe

wine_ratings <- left_join(wine_ratings,taster_names_and_gender , by = "taster_name")


# Erstellen einer Spalte im Haupt-Dataframe mit Farbe der Weine --- 

wine_color <- read.csv(file ="table_winecolor.csv", header=TRUE, sep=";", encoding = "UTF-8")



#Hinzufügen der Spalte "type" zum Haupt-Dataframe

wine_ratings <- left_join(wine_ratings, wine_color , by = "variety")


# Speichern einer neues csv-Datei

write.csv2(wine_ratings, file = "wine_ratings_clean.csv", sep=";", fileEncoding = "UTF-8", row.names = FALSE)


