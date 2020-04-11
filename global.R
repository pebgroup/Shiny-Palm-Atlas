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
Caryota <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/Caryota.csv", header = TRUE)

shape <- readOGR(dsn= 'C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp', layer = 'level3')

Botcon <- geojsonio::geojson_read("level3link.geojson", what = "sp")
shape@data$id <- rownames(shape@data)

