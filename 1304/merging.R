#reading in the palm occ csv
Palms <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/palms_in_tdwg3.csv", header = TRUE)

#Below one seems to work
shapefile_path <- "C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp"
#named it BotCon so I can mess around with it separate to main app. 
BotCon <- st_read(paste(shapefile_path, "/level3.shp", sep=""))

#these packages are to create the species presence absence matrix 
install.packages("fossil")
install.packages("cluster.datasets")
library(fossil)
library(cluster.datasets)

#and now creating the species presence absence matrix
PresAb <- create.matrix(Palms, tax.name = "SpecName", locality = "Area_code_L3")
str(PresAb)

#however matrix isn't useful the way i want it, so transform to a dataframe 
#it also needs to be transposed so countries are on the y axis. 
PresAb.df <- as.data.frame(t(PresAb))

#y axis labels need to be their own named row so this bit
PresAb.dfnamed <- cbind(LEVEL3_COD = rownames(PresAb.df), PresAb.df)

#can then merge BotCon with PresAbdf.named by their country code column.
jointdataset <- merge.data.frame(BotCon, PresAb.dfnamed, by = 'LEVEL3_COD', all.y=TRUE)

#this is what wolf did, first selecting a species name 
#and this is the bit where I'd like some help plotting the shapes against the 1s and 0s of my species please!
sp <- "Caryota_maxima"
plot(jointdataset[sp])

#I then want to introduce it into this leaflet map here, and was assuming I could just bang it in 
#however, realise I should've tried with Wolfs example of doing it first, rather than replicating first :/
leaflet(BotCon) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE, color = "burlywood4", smoothFactor = 0.3, weight = 1, fillOpacity = 0.2, 
              highlightOptions = highlightOptions(color = "darkgreen", weight = 3,
                                                  bringToFront = TRUE))