getwd()
setwd("./rawdata")

# import PRPO - POŠKODBA OSEBE IN KLASIFIKACIJA NESREČE
# NOTE and TODO: The codes file uses multiple whitespaces as variable separtor. 
# read.table() does not support multiple chars as separators,
# possible solution is described in :
# http://r.789695.n4.nabble.com/multiple-separators-in-sep-argument-for-read-table-td856567.html
download.file(url="http://policija.si/baza/PRPO.TXT", destfile="./sifranti/PRPO.txt")
sifrantPRPO <- read.table("./sifranti/PRPO.txt", header = FALSE, fileEncoding = "WINDOWS-1250", skip=1, strip.white=TRUE, sep="      ")
colnames(sifrantPRPO) <- c("PRPOSifra","PoskodbaOsebeinKlasifikacijaNesrece")
