library(stringr)
library(RVerbalExpressions)
library(wordcloud2)
library(tidytext)
library(webshot)
library(htmlwidgets)
library(tidyverse)

getwd()


# creamos un objeto string

string <- "esto es un string"

class(string)

# obtener el largo del string por caracteres
str_length(string)

string_2 <- "Houston, tenemos un problema"

# sustraer un subconjunto de caracteres
str_sub(string_2, 1, 7)

?str_sub

# lo mismo pero empezando desde el final
str_sub(string_2, -8, -1)

string_3 <-  c(" esto", "es ", " mas ", "comun ",
               "de", " lo ", " que", "pensamos ")

# Borrar los espacios
str_trim(string_3, side= "left")
str_trim(string_3, side= "right")

sin_espacios <- str_trim(string_3, side= "both")

sin_espacios

sufijo <- "España"
ciudades <- c("Madrid", "Barcelona", "Coruña")

# Pegar un sufijo a un vector
str_c(ciudades, sufijo, sep="-")

string_4 <- "MaDRiD"

# Pasar a mayusculas
str_to_upper(string_4)

# Pasar a minúsculas
str_to_lower(string_4)

# 

# Remover un objeto
rm(base)

# Garbage collector
gc()

# Cargar la base
base <- readRDS("scaloneta.RDS")

# Nos quedamos con la columna de textos de twit
twits <- as.data.frame(base$text)

# Renombramos como txt
twits <- twits %>% 
  rename(txt = 1)

# tomamos los 1eros 5 twits
primeros_twits <- twits[1:5, ]

primeros_twits

# Separamos los twtis por palabra
twits_separados <- str_split(primeros_twits, pattern = " ")

# Ingresamos a los twits como listas
twits_separados[[1]]

twits_separados[[2]][15]


primeros_twits

# Reemplazamos las @ por ""
str_replace(primeros_twits, pattern = "@", replacement = "")

# Reemplazamos # por ""
str_replace(primeros_twits, pattern = "#", replacement = "")

# Reemplazamos inicio de link por ""
str_replace_all(primeros_twits, pattern= "https://", replacement = "")

str_extract(primeros_twits, pattern = "Scaloneta")

# Extraemos la palabra scaloneta
lista_scaloneta <- str_extract_all(primeros_twits, pattern = "scaloneta")

lista_scaloneta[[5]][1]

# Dtectamos un string
str_detect(primeros_twits, "Argentina")

primeros_twits[2]

# Filtramos a partir de la detección de un string

messi2 <- twits %>% 
  filter(str_detect(txt, pattern="(M|m)essi"))

messi3 <- twits %>% 
  filter(str_detect(txt, pattern="[Mm]essi"))

# Filtramos detectando un ancla de inicio
empieza_scaloneta <- twits %>% 
  filter(str_detect(string= txt, pattern= "^Scaloneta"))

# Filtramos detectando un ancla final
termina_sca <- twits %>% 
  filter(str_detect(txt, pattern= "scaloneta$"))
  
head(termina_sca)
  
###
#install.packages("tidytext")
library(tidytext)

?unnest_tokens

# Tokenizamos la base
tokens <- twits %>% 
  unnest_tokens(input= txt, output= palabras)

# Realizamos un conteo de palabras (O tokens)
tokens_2 <- twits %>% 
  unnest_tokens(input= txt, out= palabras) %>% 
  count(palabras, sort= TRUE)

head(tokens_2)

# Creamos una expresion regular
hashtag_mencion <- "(@|#)([^ ]*)"

# Reemplazamos la expresion regular por ""
twits_2 <- twits %>% 
  mutate(txt = str_replace_all(txt, hashtag_mencion, ""))

library(RVerbalExpressions)

# Creamos una expresión regular con funciones
webs <- rx() %>% 
  rx_find("http") %>% 
  rx_anything_but(" ")

webs

# Reemplazamos las webs por ""
twits_2 <- twits_2 %>% 
  mutate(txt = str_replace_all(txt, webs, ""))
  
# Convertimos en minúsculas
twits_2 <- twits_2 %>% 
  mutate(txt = str_to_lower(txt))

# Eliminamos los números
twits_2 <- twtis_2 %>% 
  mutate(txt = str_replace_all(txt, "[[:digit:]]", ""))

# Cargamos lista de stop words
stop_words <- read.delim('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/stop_words.csv')

# Tokenizamos nuevamente la base limpia y eliminamos las stop words

unigram <- twits_2 %>% 
  unnest_tokens(input= txt, output = word) %>% 
  na.omit() %>% 
  anti_join(stop_words)

# Realizamos un conteo de palabras
unigram <- unigram %>% 
  count(word, sort = TRUE)

# Eliminamos los 1eros 3 registros que no aportan información relevante
unigram <- unigram %>% 
  slice(-c(1:3))
#Creamos la nube de palabras
wordcloud2(unigram)

# La guardamos en un objeto

nube <- wordcloud2(unigram)

# La guardamos como formato html
saveWidget(nube, "nube_scaloneta.html", 
           selfcontained = FALSE)

# Verificamos la carpeta donde se descargó
getwd()











