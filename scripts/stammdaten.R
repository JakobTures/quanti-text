library(tidyverse)
library(xml2)

# read the xml data from the file
raw_xml <- read_xml("MDB_STAMMDATEN.XML")


# build a tibble extracting the xml nodes of interest
stammdaten <- tibble(
  nachname = xml_find_all(raw_xml, "MDB/NAMEN/NAME[last()]/NACHNAME") %>% 
    xml_text(),
  vorname = xml_find_all(raw_xml, "MDB/NAMEN/NAME[last()]/VORNAME") %>% 
    xml_text(),
  Titel = xml_find_all(raw_xml, "MDB/NAMEN/NAME[last()]/AKAD_TITEL") %>% 
    xml_text(),
  geb = xml_find_all(raw_xml, "MDB/BIOGRAFISCHE_ANGABEN/GEBURTSDATUM") %>% 
    xml_text(),
  Partei = xml_find_all(raw_xml, "MDB/BIOGRAFISCHE_ANGABEN/PARTEI_KURZ") %>% 
    xml_text(),
  religion = xml_find_all(raw_xml, "MDB/BIOGRAFISCHE_ANGABEN/RELIGION") %>% 
    xml_text(),
  erste_WP = xml_find_all(raw_xml, "MDB/WAHLPERIODEN/WAHLPERIODE[1]/WP") %>% 
    xml_text(),
  letzte_WP = xml_find_all(raw_xml, "MDB/WAHLPERIODEN/WAHLPERIODE[last()]/WP") %>% 
    xml_text()
)

# convert column to numeric
stammdaten <- stammdaten %>% 
  mutate(letzte_WP = as.numeric(letzte_WP)) %>% 
  mutate(erste_WP = as.numeric(erste_WP))

# save the data for further use
save(stammdaten, file = "stammdaten.RData")



