# Shiny-Palm-Atlas 

The CaryotAtlas is envisaged as the intial steps towards an eventual Palm Atlas, encompassing all species of Arecaceae. 

To operate the app, first highlight all script in the unified script file; do this with Ctrl/A, and then run the entire script. 
Once this data is in your global enviroment (which takes less than 2 minutes to run on the developer laptop), by going to either global, ui or server, and then clicking the "Run App" button, the app will run. 
Once this app has loaded, then clicking the "open in browser" button will allow the downloading of created datasets. 

# Cleaning levels 
This projects seeks to clean data in a reproducible and reliable manner. To this end, the coordinate cleaner package from R was chosen to supply the cleaning function; https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.13152. 

Coordinate cleaner is:
"an r ‐package to scan datasets of species occurrence records for geo‐referencing and dating imprecisions and data entry errors in a standardized and reproducible way. 
CoordinateCleaner is tailored to problems common in biological and palaeontological databases and can handle datasets with millions of records. 
The software includes: 
(a) functions to flag potentially problematic coordinate records based on geographical gazetteers
(b) a global database of 9,691 geo‐referenced biodiversity institutions to identify records that are likely from horticulture or captivity
(c) novel algorithms to identify datasets with rasterized data, conversion errors and strong decimal rounding
(d) spatio‐temporal tests for fossils." - https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.13152

Notably and importantly:
"All cleaning functions and the biodiversity institution database are open‐source and available within the CoordinateCleaner r ‐package." - https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.13152

The following code is used for the full cleaning of data:

### Code added by Ben on 14/06/2020

``` 
  cc_val()  # removes or flags non-numeric and not available coordinates 
  cc_equ()  # removes or flags records with equal latitude and longitude coordinates
  cc_cap()  # removes or flags records within a certain radius around country capitals
  cc_cen()  # removes or flags records within a radius around the geographic centroids of political countries and provinces
  cc_gbif()  # removes or flags records within a radius around the GBIF headquarters 
  cc_inst()  # removes or flags records assigned to the location of zoos, botanical gardens, herbaria, universities and museums
  cc_sea()  # removes or flags coordinates outside the reference landmass. A custom gazetteer with a 1âdegree buffer for cc_sea is used to avoid flagging records close to the coastline
  cc_zero()  # removes or flags records with either zero longitude or latitude and a radius around the point at zero longitude and zero latitude
  cc_urb()  # removes or flags records from inside urban areas
  cc_dupl(lon = "decimallongitude", lat = "decimallatitude") # removes or flags duplicated records based on species name and coordinates
```

The following code is for partial cleaning of data: 

### Code added by Ben on 14/06/2020

```
  cc_val()  # removes or flags non-numeric and not available coordinates !
  cc_equ()  # removes or flags records with equal latitude and longitude coordinates !
  cc_zero()  # removes or flags records with either zero longitude or latitude and a radius around the point at zero longitude and zero latitude !
  cc_dupl(lon = "decimallongitude", lat = "decimallatitude") # removes or flags duplicated records based on species name and coordinates !
```
