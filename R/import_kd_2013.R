# Uvoz podatkov kriminalitete iz leta 2001

setwd("./stribog/rawdata")
require(zoo) # za handlanje month-year datumov

# podatki so dostopni tule:
# http://policija.si/baza/kd2013.zip
# sicer pa so bili downloadani s strani policije 31.7.2014

leto <- "2013"
fn <- paste("kd", leto, sep = "")
dir.create(fn)
unzip(paste("./", fn, ".zip", sep = ""), exdir = paste("./kd", leto, sep = ""),)

infiles <- list.files(paste("./", fn, sep = ""), full.names = TRUE)

# all possible encodings 
#iconvlist() # brute force attack je razkril "WINDOWS-1250" kot najbolj primerno glede šumnikov et al

###################
# Kazniva dejanja #
###################
kd <- read.table(infiles[grepl("DOGODKI", infiles)], header = FALSE, sep = "$", 
   fileEncoding = "windows-1250", encoding = "UTF8", dec = ",")

# struktura baze, glej navodila_kriminaliteta.pdf
names(kd) <- c(
   "stevilkaPrimera",               #1
   "datum",                         #2
   "ura",                           #3
   "dan",                           #4
   "policijskaUprava",              #5
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
   "upravnaEnota",                  #19
   "prizorisce",                    #20
   "dokumentZakljucen	",            #21
   "ovadba"                         #22
)

# zoo reprezentacija datuma v dan.mesec formatu
kd$datum <- as.yearmon(kd$datum, format = "%m.%Y")

as.data.frame(table(kd$poglavjeZakonika))
table(kd$povratnik)
as.data.frame(table(kd$dan))
as.data.frame(table(kd$uporabljenoSredstvo1))
as.data.frame(table(kd$prizorisce))

plot(table(kd$datum))











# TODO:
kdo <- read.table(infiles[grepl("OSEBE", infiles)], header = FALSE, sep = "$", fileEncoding = "windows-1250", encoding = "UTF8")

# spucaj šifrant
sif <- readLines(infiles[grepl("SIFRANTI", infiles)], encoding = "WINDOWS-1250")