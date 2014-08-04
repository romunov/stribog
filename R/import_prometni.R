# Uvoz podatkov o prometni varnosti - Traffic safety records import

# set working directory
getwd
setwd("./rawdata/prometni/pn2013")

# list of years to import
yearsToImport <- c("2013","2012", "2011", "10", "09", "08", "07", "06", "05", "04", "03", "02", "01", "00", "99","98","97","96","95" )

# read data for 2013
leto2013 <- importTrafficData("2013")
# rename columns
leto2013[[1]] <- nameOsebeColumns(leto2013[[1]])
leto2013[[2]] <- nameDogodkiColumns(leto2013[[2]]) 

# save data to see what happens encoding wise
write.csv(leto2013[[1]], file="OsebeExport.csv")
write.csv(leto2013[[2]], file="DogodkiExport.csv")

# generic function to import traffic data
# NOTE: valid for year 2013!
# takes the year as an argument
importTrafficData <- function (leto) {
  # fileUrl <- paste0("http://policija.si/baza/pn", leto, ".zip") # construct URL of ZIP file with data
  # tempFile <- tempfile() # assign a temp file on hard drive
  # download.file(url=fileUrl, destfile=tempFile) # download the ZIP file into the temp file
  
  # load data into tables for OSEBE and DOGODKI
  # dataOsebe <- read.table(unz(description = tempFile, filename = "OSEBE.TXT"), encoding="WINDOWS-1250", header = FALSE, sep="$", colClasses="character")
  # dataDogodki <- read.table(unz(description = tempFile, filename = "DOGODKI.TXT"), encoding="WINDOWS-1250", header = FALSE, sep="$", colClasses="character")
  # unlink(tempFile) # remove temp file
  
  dataOsebe <- read.table("OSEBE.TXT",
                          header = FALSE, sep = "$", fileEncoding = "WINDOWS-1250", colClasses="character")
  dataDogodki <- read.table("DOGODKI.TXT",
                            header = FALSE, sep = "$", fileEncoding = "WINDOWS-1250", colClasses="character")  
  return(list(dataOsebe, dataDogodki)) # return a list with both data frames
}

# name columns os OSEBE table 
# NOTE: valid for year 2013!
nameOsebeColumns <- function(data) {
  colnames(data) <- c("stevilkaZadeve",
                      "unknown",
                      "vlogaOsebe",
                      "starost",
                      "spol",
                      "obcina",
                      "drzavljanstvo",
                      "poskodba",
                      "vrstaUdelezenca",
                      "uporabaPasuCelade",
                      "vozniskiStaz",
                      "vrednostAlkotesta",
                      "vrednostStrokovnegaPregleda",
                      "empty"
  )
  return(data)
}

# name columns of DOGODKI table 
# NOTE: valid for year 2013!
nameDogodkiColumns <- function(data) {
  colnames(data) <- c("stevilkaZadeve",
                      "klasifikacijaNesrece",
                      "upravnaEnotaDogodka",
                      "datumNesrece",
                      "uraNesrece",
                      "naseljeAliIzven",
                      "kategorijaCeste",
                      "oznakaCestaAliNaselja?",
                      "oznakaCestaAliNaselja?",
                      "tekstCesteAliNaselja",
                      "tekstOdsekaAliUlice",
                      "stacionazaAliHisnaStevilka",
                      "opisPrizorisca",
                      "glavniVzrok",
                      "tipNesrece",
                      "vremenskeOkoliscine",
                      "stanjePrometa",
                      "stanjeVozisca",
                      "stanjePovrsineVozisca"
  )
  return(data)
}



# OBSOLETE ####
# loop to import data for several years
# NOTE: the filenames are different through the years, so the import function will not work...
podatki <- list()
for (leto in seznamLet) {
  podatki[[leto]] <- importTrafficData(leto)
  
}
