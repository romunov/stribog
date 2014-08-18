# Uvoz podatkov kriminalitete za leto 2012. Uporablja funkcijo importKD2013, ki za
# te podatke še deluje.

setwd("./stribog")

dir.create("./rawdata/kd2012")
download.file("http://policija.si/baza/kd2012.zip", "./rawdata/kd2012.zip")
unzip("./rawdata/kd2012.zip", exdir = "./rawdata/kd2012")

kd <- importKD2013(kd.file = "./rawdata/kd2012/kd.txt", 
   kdo.file = "./rawdata/kd2012/kdo.txt",
   sifranti = "./data/sifranti.RData")

save(list = "kd", file = "./data/kd2012.RData", envir = as.environment(kd))
save(list = "kdo", file = "./data/kdo2012.RData", envir = as.environment(kd))
