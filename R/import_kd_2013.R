#' Ta funkcija uvozi podatke o kriminaliteti iz leta 2013
#' @param kd.file Character. Vektor poti do datoteke o dogodkih kaznivih dejanj.
#' @param kdo.file Character. Vektor poti do datoteke o osebah udeleženih v kaznivih dejanjih.
#' @param sifranti Character. Pot do sifranti.RData.
#' @author Roman Luštrik

importKD2013 <- function(kd.file, kdo.file, sifranti) {
   require(zoo) # za handlanje month-year datumov
   require(stringr) # trimming whitespace
   
   ###################
# Kazniva dejanja #
   ###################
   kd <- read.table(kd.file, header = FALSE, sep = "$", 
      fileEncoding = "windows-1250", encoding = "UTF8", dec = ",")
   
   # import sifranti into new environment to keep things tidy
   ne <- new.env()
   load(sifranti, envir = ne)
   
# struktura baze, glej navodila_kriminaliteta.pdf
   names(kd) <- c(
      "stevilkaPrimera",               #1
      "datum",                         #2
      "ura",                           #3
      "dan",                           #4
      "policijskaUpravaKoda",          #5
      "klasifikacijaKaznivegaDejanja", #6
      "poglavjeZakonika",              #7
      "gospodarskaKriminaliteta",      #8
      "organiziranaKriminaliteta",     #9
      "mladoletniskaKriminaliteta",    #10
      "povratnik",                     #11
      "kriminalisticnaOznacba1",       #12
      "kriminalisticnaOznacba2",       #13
      "kriminalisticnaOznacba3",       #14
      "uporabljenoSredstvo1",          #15
      "uporabljenoSredstvo2",          #16 
      "uporabljenoSredstvo3",          #17
      "uporabljenoSredstvo4",          #18
      "upravnaEnotaKoda",              #19
      "prizorisce",                    #20
      "dokumentZakljucen	",            #21
      "ovadba"                         #22
   )
   
# zoo reprezentacija datuma v dan.mesec formatu
   kd$datum <- as.yearmon(kd$datum, format = "%m.%Y")
   
# spucaj šifrant
#   sif.in <- readLines(infiles[grepl("SIFRANTI", infiles)], encoding = "WINDOWS-1250")
#   sif.lopm <- sif.in[grep("LOPM", sif.in):length(sif.in)]
#   sif.lopm <- strsplit(sif.lopm, split = "      ")
## sestavi razrezan list character vektorjev
#   sif.lopm <- do.call("rbind", lapply(sif.lopm[-1], FUN = function(x) data.frame(koda = x[1], lopm = x[3])))
   sif.lopm <- ne$LOPM
   
   # upravne enote in stare občine
#   sif.loob <- sif.in[grep("LOOB", sif.in):grep("LOPM", sif.in)]
#   sif.loob <- sif.loob[-c(1, length(sif.loob))]
#   sif.loob <- strsplit(sif.loob, split = "       ")
#   sif.loob <- do.call("rbind", lapply(sif.loob, FUN = function(x) {
#            x <- str_trim(x)
#            data.frame(koda = x[1], loob = x[2])
#         }))
   sif.loob <- ne$LOOB
   
   kd <- merge(x = kd, y = sif.lopm, by.x = "policijskaUpravaKoda", by.y = "LOPMSifra", all.x = TRUE)
   kd <- merge(x = kd, y = sif.loob, by.x = "upravnaEnotaKoda", by.y = "LOOBSifra", all.x = TRUE)
   
   
# spucaj uporabljenoSredstvo
   lvl.us1 <- levels(kd$uporabljenoSredstvo1)
   levels(kd$uporabljenoSredstvo1) <- str_trim(gsub("(,D)|(,S)|(,N)|(,X)", replacement = "", x = lvl.us1))
   
   lvl.us2 <- levels(kd$uporabljenoSredstvo2)
   levels(kd$uporabljenoSredstvo2) <- str_trim(gsub("(,X)|(,N)|(,D)|(,S)|(^[ \t],)", replacement = "", x = lvl.us2))
   
   lvl.us3 <- levels(kd$uporabljenoSredstvo3)
   levels(kd$uporabljenoSredstvo3) <- str_trim(gsub("(,X)|(,N)|(,D)|(,S)|(^[ \t],)", replacement = "", x = lvl.us3))
   
   lvl.us4 <- levels(kd$uporabljenoSredstvo4)
   levels(kd$uporabljenoSredstvo4) <- str_trim(gsub("(,X)|(,N)|(,D)|(,S)|(^[ \t],)", replacement = "", x = lvl.us4))
   
   
   ###########################
# Kazniva dejanja - osebe #
   ###########################
   kdo <- read.table(kdo.file, header = FALSE, sep = "$", fileEncoding = "windows-1250", encoding = "UTF8")
   names(kdo) <- c(
      "stevilkaZadeve",  #1
      "vloga",           #2
      "starostnaSkupina", #3
      "spol", #4
      "drzavljanstvo", #5
      "poskodbaOsebe", #6
      "vplivAlkohola", #7
      "vplivMamil", #8
      "pripadnostOrganiziraniZdruzbi", #9
      "materialnaSkoda" #10 v SIT, EUR
   )
   
   levels(kdo$drzavljanstvo) <- str_trim(levels(kdo$drzavljanstvo))
   levels(kdo$poskodbaOsebe) <- str_trim(levels(kdo$poskodbaOsebe))
   
   out <- list(kd = kd, kdo = kdo)
}

#' @examples
setwd("./stribog")

# podatki so dostopni tule:
# http://policija.si/baza/kd2013.zip
# sicer pa so bili downloadani s strani policije 31.7.2014

#unzip(paste("./", fn, ".zip", sep = ""), exdir = paste("./kd", leto, sep = ""),)
dir.create("./rawdata/kd2013")
download.file("http://policija.si/baza/kd2013.zip", "./rawdata/kd2013.zip")
unzip("kd2013.zip", exdir = "./rawdata/kd2013")

imp <- importKD2013(kd.file = "./rawdata/kd2013/DOGODKI.TXT",
   kdo.file = "./rawdata/kd2013/OSEBE.TXT",
   sifranti = "./data/sifranti.RData")

#save(imp$kd, file = "../data/kd2013.RData")
#save(imp$kdo, file = "../data/kdo2013.RData")
