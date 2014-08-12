# import code lists for "Prometna varnost" ####

getwd()
setwd("/home/crtah/R/Projects/stribog/rawdata/sifrantiPN/")

# a general function to import code pages form signle files
importCodePage <- function(codepageFileName, columnNames) {
  # construct source URL
  sourceURL <- paste0("http://policija.si/baza/", codepageFileName)
  # download file
  download.file(url=sourceURL, destfile=codepageFileName)
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
  # close uneeded connection
  close(con)
  # save source of data and date accesed
  attr(codePage, which = "SourceURL") <- sourceURL
  attr(codePage, which = "DateAccesed") <- Sys.time()
  # return the code page
  return(codePage)
}

# import each code page separately
# "Prometna varnost" group of code pages
PRPO <- importCodePage(codepageFileName="PRPO.TXT", c("PRPOSifra","PoskodbaOsebeinKlasifikacijaNesrece"))
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
PRVU <- importCodePage(codepageFileName="PRVU.TXT", c("PRVUSifra","SifrantVrsteUdelezencavPrometu"))
# "Kriminaliteta" group of code pages
LOPM <- importCodePage(codepageFileName="lopm.txt", c("LOPMSifra","SifrantPolicijskihUprav")) # error about incomplete final line!
# it does not seem t ohave CR/LF ending, but it gets imported nonetheless...
KDKO <- importCodePage(codepageFileName="KDKO.TXT", c("KDKOSifra","KDKriminalisticnaOznacba")) # error about incomplete final line!
# it does not seem t ohave CR/LF ending, but it gets imported nonetheless...
KDSP <- importCodePage(codepageFileName="KDSP.TXT", c("KDSPSifra","KDUporabljenoSredstvoPredmetKD"))
KDPR <- importCodePage(codepageFileName="KDPR.TXT", c("KDPRSifra","KDPodrobenOpisPrizorisca"))


# save the code pages into RData file
setwd("/home/crtah/R/Projects/stribog/data/")
importedCodePages <- c(
  "PRPO","LOOB","LOVC","PRKD","PRVZ","PRTN","PRVR","PRSP","PRPV","PRSV","LODZ","PRVU","LOPM","KDKO","KDSP","KDPR")
save(list=importedCodePages, file="sifranti.RData")


