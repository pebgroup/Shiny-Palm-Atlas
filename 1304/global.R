#install.packages(c("shiny","leaflet","sf","dplyr","geojsonio","rgdal","magrittr","jsonlite"))
library(shiny)
library(leaflet) 
library(sf)
library(dplyr)
library(geojsonio)
library(rgdal)
library(magrittr)
library(jsonlite)

getwd()
setwd("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R")
#read in caryota data
#Caryota <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/Caryota.csv", header = TRUE)
#read in geojson file
#Botcon <- geojsonio::geojson_read("level3link.geojson", what = "sp")
#read in palm occ data
Palms <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/palms_in_tdwg3.csv", header = TRUE)
#read in shape file 
shape <- readOGR(dsn= 'C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp', layer = 'level3')

#palm traits people did this, figuring out.
shape@data$id <- rownames(shape@data)

