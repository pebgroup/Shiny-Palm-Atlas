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
library(spocc)
library(magrittr)
library(sf)
library(tibble)
library(dplyr)
library(rlang)

#please note files are only downloadable if sightings are "accepted" classification 

#Caryota albertii, no locality data

dfa_cal <- occ(query = 'Caryota albertii', from = 'ala')
dfa_cal <- as.data.frame(dfa_cal$ala$data) %>% 
  transmute(species = Caryota_albertii.name, 
            decimallongitude = as.numeric(Caryota_albertii.longitude),
            decimallatitude = as.numeric(Caryota_albertii.latitude),
            year = Caryota_albertii.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_albertii.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_albertii.basisOfRecord,
            recorded_by = Caryota_albertii.collector,
            record_number= Caryota_albertii.recordNumber,
            institution_code =  Caryota_albertii.raw_institutionCode)
            #locality = Caryota_albertii.raw_locationRemarks)

dfa_cal$locality <- NA

#Caryota angustifolia

dfa_can <- occ(query = 'Caryota angustifolia', from = 'ala')
dfa_can <- as.data.frame(dfa_can$ala$data) %>% 
  transmute(species = Caryota_angustifolia.name, 
            decimallongitude = as.numeric(Caryota_angustifolia.longitude),
            decimallatitude = as.numeric(Caryota_angustifolia.latitude),
            year = Caryota_angustifolia.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_angustifolia.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_angustifolia.basisOfRecord,
            recorded_by = Caryota_angustifolia.collector,
            record_number= Caryota_angustifolia.recordNumber,
            institution_code = Caryota_angustifolia.raw_institutionCode,
            locality = Caryota_angustifolia.raw_locationRemarks)

#Caryota cumingii

dfa_ccu <- occ(query = 'Caryota cumingii', from = 'ala')
dfa_ccu <- as.data.frame(dfa_ccu$ala$data) %>% 
  transmute(species = Caryota_cumingii.name, 
            decimallongitude = as.numeric(Caryota_cumingii.longitude),
            decimallatitude = as.numeric(Caryota_cumingii.latitude),
            year = Caryota_cumingii.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_cumingii.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_cumingii.basisOfRecord,
            recorded_by = Caryota_cumingii.collector,
            record_number= Caryota_cumingii.recordNumber,
            institution_code = Caryota_cumingii.raw_institutionCode,
            locality = Caryota_cumingii.raw_locationRemarks)

#Caryota kiriwongensis

dfa_cki <- occ(query = 'Caryota kiriwongensis', from = 'ala')
dfa_cki <- as.data.frame(dfa_cki$ala$data) %>% 
  transmute(species = Caryota_kiriwongensis.name, 
            decimallongitude = as.numeric(Caryota_kiriwongensis.longitude),
            decimallatitude = as.numeric(Caryota_kiriwongensis.latitude),
            year = Caryota_kiriwongensis.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_kiriwongensis.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_kiriwongensis.basisOfRecord,
            recorded_by = Caryota_kiriwongensis.collector,
            record_number= Caryota_kiriwongensis.recordNumber,
            institution_code = Caryota_kiriwongensis.raw_institutionCode,
            locality = Caryota_kiriwongensis.raw_locationRemarks)

#Caryota maxima

dfa_cma <- occ(query = 'Caryota maxima', from = 'ala')
dfa_cma <- as.data.frame(dfa_cma$ala$data) %>% 
  transmute(species = Caryota_maxima.name, 
            decimallongitude = as.numeric(Caryota_maxima.longitude),
            decimallatitude = as.numeric(Caryota_maxima.latitude),
            year = Caryota_maxima.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_maxima.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_maxima.basisOfRecord,
            recorded_by = Caryota_maxima.collector,
            record_number= Caryota_maxima.recordNumber,
            institution_code = Caryota_maxima.raw_institutionCode,
            locality = Caryota_maxima.raw_locationRemarks)

#Caryota mitis

dfa_cmi <- occ(query = 'Caryota mitis', from = 'ala')
dfa_cmi <- as.data.frame(dfa_cmi$ala$data) %>% 
  transmute(species = Caryota_mitis.name, 
            decimallongitude = as.numeric(Caryota_mitis.longitude),
            decimallatitude = as.numeric(Caryota_mitis.latitude),
            year = Caryota_mitis.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_mitis.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_mitis.basisOfRecord,
            recorded_by = Caryota_mitis.collector,
            record_number= Caryota_mitis.recordNumber,
            institution_code = Caryota_mitis.raw_institutionCode,
            locality = Caryota_mitis.raw_locationRemarks)

#Caryota monostachya

dfa_cmo <- occ(query = 'Caryota monostachya', from = 'ala')
dfa_cmo <- as.data.frame(dfa_cmo$ala$data) %>% 
  transmute(species = Caryota_monostachya.name, 
            decimallongitude = as.numeric(Caryota_monostachya.longitude),
            decimallatitude = as.numeric(Caryota_monostachya.latitude),
            year = Caryota_monostachya.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_monostachya.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_monostachya.basisOfRecord,
            recorded_by = Caryota_monostachya.collector,
            record_number= Caryota_monostachya.recordNumber,
            institution_code = Caryota_monostachya.raw_institutionCode,
            locality = Caryota_monostachya.raw_locationRemarks)

#Caryota no

dfa_cno <- occ(query = 'Caryota no', from = 'ala')
dfa_cno <- as.data.frame(dfa_cno$ala$data) %>% 
  transmute(species = Caryota_no.name, 
            decimallongitude = as.numeric(Caryota_no.longitude),
            decimallatitude = as.numeric(Caryota_no.latitude),
            year = Caryota_no.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_no.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_no.basisOfRecord,
            recorded_by = Caryota_no.collector,
            record_number= Caryota_no.recordNumber,
            institution_code = Caryota_no.raw_institutionCode,
            locality = Caryota_no.raw_locationRemarks)

#Caryota obtusa

dfa_cob <- occ(query = 'Caryota obtusa', from = 'ala')
dfa_cob <- as.data.frame(dfa_cob$ala$data) %>% 
  transmute(species = Caryota_obtusa.name, 
            decimallongitude = as.numeric(Caryota_obtusa.longitude),
            decimallatitude = as.numeric(Caryota_obtusa.latitude),
            year = Caryota_obtusa.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_obtusa.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_obtusa.basisOfRecord,
            recorded_by = Caryota_obtusa.collector,
            record_number= Caryota_obtusa.recordNumber,
            institution_code = Caryota_obtusa.raw_institutionCode,
            locality = Caryota_obtusa.raw_locationRemarks)

#Caryota ophiopellis

dfa_cop <- occ(query = 'Caryota ophiopellis', from = 'ala')
dfa_cop <- as.data.frame(dfa_cop$ala$data) %>% 
  transmute(species = Caryota_ophiopellis.name, 
            decimallongitude = as.numeric(Caryota_ophiopellis.longitude),
            decimallatitude = as.numeric(Caryota_ophiopellis.latitude),
            year = Caryota_ophiopellis.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_ophiopellis.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_ophiopellis.basisOfRecord,
            recorded_by = Caryota_ophiopellis.collector,
            record_number= Caryota_ophiopellis.recordNumber,
            institution_code = Caryota_ophiopellis.raw_institutionCode,
            locality = Caryota_ophiopellis.raw_locationRemarks)

#Caryota rumphiana

dfa_cru <- occ(query = 'Caryota rumphiana', from = 'ala')
dfa_cru <- as.data.frame(dfa_cru$ala$data) %>% 
  transmute(species = Caryota_rumphiana.name, 
            decimallongitude = as.numeric(Caryota_rumphiana.longitude),
            decimallatitude = as.numeric(Caryota_rumphiana.latitude),
            year = Caryota_rumphiana.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_rumphiana.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_rumphiana.basisOfRecord,
            recorded_by = Caryota_rumphiana.collector,
            record_number= Caryota_rumphiana.recordNumber,
            institution_code = Caryota_rumphiana.raw_institutionCode,
            locality = Caryota_rumphiana.raw_locationRemarks)

#Caryota sympetala

dfa_csy <- occ(query = 'Caryota sympetala', from = 'ala')
dfa_csy <- as.data.frame(dfa_csy$ala$data) %>% 
  transmute(species = Caryota_sympetala.name, 
            decimallongitude = as.numeric(Caryota_sympetala.longitude),
            decimallatitude = as.numeric(Caryota_sympetala.latitude),
            year = Caryota_sympetala.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_sympetala.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_sympetala.basisOfRecord,
            recorded_by = Caryota_sympetala.collector,
            record_number= Caryota_sympetala.recordNumber,
            institution_code = Caryota_sympetala.raw_institutionCode,
            locality = Caryota_sympetala.raw_locationRemarks)

#Caryota urens

dfa_cur <- occ(query = 'Caryota urens', from = 'ala')
dfa_cur <- as.data.frame(dfa_cur$ala$data) %>% 
  transmute(species = Caryota_urens.name, 
            decimallongitude = as.numeric(Caryota_urens.longitude),
            decimallatitude = as.numeric(Caryota_urens.latitude),
            year = Caryota_urens.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_urens.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_urens.basisOfRecord,
            recorded_by = Caryota_urens.collector,
            record_number= Caryota_urens.recordNumber,
            institution_code = Caryota_urens.raw_institutionCode,
            locality = Caryota_urens.raw_locationRemarks)

#Caryota zebrina

dfa_cze <- occ(query = 'Caryota zebrina', from = 'ala')
dfa_cze <- as.data.frame(dfa_cze$ala$data) %>% 
  transmute(species = Caryota_zebrina.name, 
            decimallongitude = as.numeric(Caryota_zebrina.longitude),
            decimallatitude = as.numeric(Caryota_zebrina.latitude),
            year = Caryota_zebrina.year,
            coordinateUncertaintyInMeters = as.numeric(Caryota_zebrina.coordinateUncertaintyInMeters),
            basisOfRecord= Caryota_zebrina.basisOfRecord,
            recorded_by = Caryota_zebrina.collector,
            record_number= Caryota_zebrina.recordNumber,
            institution_code = Caryota_zebrina.raw_institutionCode,
            locality = Caryota_zebrina.raw_locationRemarks)

#dfa_all <- rbind(dfa_cal, dfa_can, dfa_ccu, dfa_cki, dfa_cma, dfa_cmi, dfa_cmo, dfa_cno, dfa_cob, dfa_cop, dfa_cru, dfa_csy, dfa_cur, dfa_cze)

dfa_all <- rbind(dfa_cal, dfa_cmi, dfa_cur)

dfa_all$observation_count <- NA

dfa_all$database_name <- "ala"

