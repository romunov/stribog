# import code lists for "Prometna varnost" ####

getwd()
setwd("/home/crtah/R/Projects/stribog/rawdata/sifrantiPN/")

# a general function to import code pages form signle files
importCodePage <- function(codepageFileName, columnNames) {
  # download file
  download.file(url=paste0("http://policija.si/baza/", codepageFileName), destfile=codepageFileName)
  # read lines in downloaded file
  lines <- readLines(file(codepageFileName, encoding = "WINDOWS-1250"))
  # remove space in front of lines
  temp <- gsub(pattern = "^[ ]{1,255}", replacement = "", x=lines)
  # remove spaces at back of lines
  temp <- gsub(pattern = "[ ]{1,255}$", replacement = "", x=temp)
  # replace more than x spaces inside the remainig text with a ";"
  temp <- gsub(pattern = "[ ]{3,255}", replacement = ";", x=temp)
  # open a text connection for read.table to read
  con <- textConnection(temp)
  # read the data into a table
  codePage <- read.table(con, header = FALSE, fileEncoding = "WINDOWS-1250", skip=2, strip.white=TRUE, sep=";")
  # rename columns in code page
  colnames(codePage) <- columnNames
  
  return(codePage)
}

# import PRPO - POŠKODBA OSEBE IN KLASIFIKACIJA NESREČE
PRPO <- importCodePage(codepageFileName="PRPO.TXT", c("PRPOSifra","PoskodbaOsebeinKlasifikacijaNesrece"))
# etc ...
LOOB <- importCodePage(codepageFileName="LOOB.TXT", c("LOOBSifra","SifrantUpravnihEnotinStarihObcin"))
LOVC <- importCodePage(codepageFileName="LOVC.TXT", c("LOVCSifra","KategorijaCesteNaselja"))
PRKD <- importCodePage(codepageFileName="PRKD.TXT", c("PRKDSifra","OpisKrajaDogodka"))
PRVZ <- importCodePage(codepageFileName="PRVZ.TXT", c("PRVZSifra","VzrokPrometneNesrece"))
PRTN <- importCodePage(codepageFileName="PRTN.TXT", c("PRTNSifra","TipPrometneNesrece"))
PRVR <- importCodePage(codepageFileName="PRVR.TXT", c("PRVRSifra","VremenskeOkoliscine"))
PRSP <- importCodePage(codepageFileName="PRSP.TXT", c("PRSPSifra","StanjePrometavCasuPrometneNesrece"))
PRPV <- importCodePage(codepageFileName="PRPV.TXT", c("PRPVSifra","StanjeVoziscavCasuPrometneNesrece"))
PRSV <- importCodePage(codepageFileName="PRSV.TXT", c("PRSVSifra","VrstaVoziscavCasuPrometneNesrece"))
LODZ <- importCodePage(codepageFileName="LODZ.TXT", c("LODZSifra","SifrantDrzav")) # error about incomplete final line!
# it does not seem t ohave CR/LF ending, but it gets imported nonetheless...


### OBSOLETE CODE ####

# import PRPO - POŠKODBA OSEBE IN KLASIFIKACIJA NESREČE
# NOTE and TODO: The codes file uses multiple whitespaces as variable separtor. 
# read.table() does not support multiple chars as separators,
# possible solution is described in :
# http://r.789695.n4.nabble.com/multiple-separators-in-sep-argument-for-read-table-td856567.html

# download file
download.file(url="http://policija.si/baza/PRPO.TXT", destfile="./PRPO.txt")
# read lines in downloaded file
lines <- readLines(file("PRPO.txt", encoding = "WINDOWS-1250"))
# remove space in front of lines
temp <- gsub(pattern = "^[ ]{2,255}", replacement = "", x=lines)
# remove spaces at back of lines
temp <- gsub(pattern = "[ ]{2,255}$", replacement = "", x=temp)
# replace more than two spaces inside the remainig text with a ";"
temp <- gsub(pattern = "[ ]{2,255}", replacement = ";", x=temp)
# open a text connection for read.table to read
con <- textConnection(temp)
# read the data into a table
sifrantPRPO <- read.table(con, header = FALSE, fileEncoding = "WINDOWS-1250", skip=2, strip.white=TRUE, sep=";")
# rename columns in code page
colnames(sifrantPRPO) <- c("PRPOSifra","PoskodbaOsebeinKlasifikacijaNesrece")
sifrantPRPO