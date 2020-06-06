 #install.packages(c("shiny","leaflet","sf","dplyr","geojsonio","rgdal","magrittr","jsonlite","shinythemes","fossil","cluster.datasets"))
library(shiny)
library(shinydashboard)
library(leaflet) 
library(dplyr)
library(rgdal)
library(magrittr)
#library(jsonlite)
#library(geojsonio)
library(lubridate) 
library(CoordinateCleaner) # for automatic flagging of common spatial and temporal errors in biological collection data
library(biogeo) # for error detection and correction in point data quality datasets
library(rgbif) # a programmatic inferface to the Global Biodiversity Information Facility (GBIF)
library(BIEN) # provides access to the BIEN database as well as useful tools for working with the BIEN data.
library(raster) # for handling rasters both in memory and on disk
library(sf) # to implement simple features, a standardised way of encoding spatial vector data 
library(sp) # for importing, manipulating and exporting spatial data 
library(maptools) # tools for manipulating geographic data
library(rgeos) # implements functionality for the manipulation and querying of spatial geometries 
library(tidyverse) # a coherent system of R packages for data manipulation, exploration and  
library(ALA4R)
library(spocc) #occurence pulling functions 
library(tibble)
library(rlang)
library(htmltools)
#these packages are to create the species presence absence matrix 
#library(fossil)
#library(cluster.datasets)


#read in caryota data
#Caryotabin <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/Caryotabin.csv", header = TRUE)
Caryotalist <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/Caryotalist.csv", header = TRUE)

Caryota <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/Caryota.csv", header = TRUE)
#read in geojson file
#Botcon <- geojsonio::geojson_read("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/level3link.geojson", what = "sp")
#read in palm occ data
#read in shape file 
#shape <- readOGR(dsn= 'C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp', layer = 'level3')

getwd()
setwd("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R")

#reading in PalmTraits + shapefile 
#Palms <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/palms_in_tdwg3.csv", header = TRUE)
shapefile_path <- "C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp"
BotCon <- st_read(paste(shapefile_path, "/level3.shp", sep=""))

#script for presence absence attached to shapefile
#source("PalmAtlas/merging.R")

#look <- Caryotalist[Caryotalist$value == 1,]


