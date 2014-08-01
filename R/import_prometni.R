# Uvoz podatkov o prometni varnosti - Traffic safety records import

# generic function to import traffic data
# takes the year as an argument
importTrafficData <- function (leto) {
  fileUrl <- paste0("http://policija.si/baza/pn", leto, ".zip") # construct URL of ZIP file with data
  tempFile <- tempfile() # assign a temp file on hard drive
  download.file(url=fileUrl, destfile=tempFile) # download the ZIP file into the temp file
  
  # load data into tables for OSEBE and DOGODKI
  dataOsebe <- read.table(unz(description = tempFile, filename = "OSEBE.TXT"), encoding="WINDOWS-1250", header = FALSE, sep="$")
  dataDogodki <- read.table(unz(description = tempFile, filename = "DOGODKI.TXT"), encoding="WINDOWS-1250", header = FALSE, sep="$")
  unlink(tempFile) # remove temp file
return(list(dataOsebe, dataDogodki)) # return a list with both data frames
}

# list of years to import
seznamLet <- c("2013","2012", "2011")

# loop to import data for several years
# NOTE: the filenames are different through the years, so the import function will not work...
podatki <- list()
for (leto in seznamLet) {
  podatki[[leto]] <- importTrafficData(leto)
  
}

# test reading data
x <- importTrafficData("2013")
