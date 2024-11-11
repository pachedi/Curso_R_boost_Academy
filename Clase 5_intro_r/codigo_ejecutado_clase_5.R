
# Consulta marianela
vacunas <- read.csv("base_vacunas_tarea.csv")


agrupado <- vacunas %>% 
  group_by(VACUNA, GENERO) %>% 
  summarise(dosis_1 = sum(DOSIS_1),
            dosis_2 = sum(DOSIS_2),
            dosis_3 = sum(DOSIS_3))

por_dia <- vacunas %>% 
  mutate(total_vacunas = DOSIS_1+DOSIS_2+DOSIS_3,
         FECHA_ADMINISTRACION = ymd(FECHA_ADMINISTRACION)) %>% 
  group_by(FECHA_ADMINISTRACION, GENERO) %>% 
  summarise(total_vacunas = sum(total_vacunas))


ggplot(data=por_dia, aes(x= FECHA_ADMINISTRACION, y=total_vacunas, col=GENERO))+
  geom_line()+
  scale_x_date(date_breaks = "1 month")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=90))+
  scale_color_manual(labels= c("Femenino", "Masculino",
                               "No binario"),
                     values = c("red", "blue",
                                 "green"))+
  labs(x="Total de vacunas aplicadas", y= "Fecha",
       title= "Vacunas aplicadas por genero", 
       subtitle= "Ciudad autónoma de Buenos Aires")+
  facet_wrap(~GENERO)
  

#################

library(tidyverse)

#install.packages(c("stringr", "wordcloud2", "RVerbalExpressions","webshot",
#                   "htmlwidgets"))


library(stringr)
library(wordcloud2)
library(RVerbalExpressions)
library(htmlwidgets)
library(webshot)


string <- "esto es un string"

string

# Largo de string
str_length(string)

string_2 <- "Houston, tenemos un problema"

str_sub(string_2, 1,7)

str_sub(string_2, -8, -1)

#Eliminar espacios no deseados
string_3 <- c("  hola", "esto  ", " es ", "problematico ")

str_trim(string_3, side="left")

str_trim(string_3, side="right")
  
str_trim(string_3, side="both")

# Pegar texto
sufijo <- "Buenos Aires"
municipios <- c("Vicente Lopez", "Berazategui", "La Matanza", 
                "Moron", "San Martin")

str_c(municipios, sufijo, sep="/")

string_4 <- "HoLa MAyusCUlas y MINUSculas"

# Minusculay Mayuscula
str_to_lower(string_4)
str_to_upper(string_4)

setwd("../Clase 5_intro_r/")

twits <- readRDS("scaloneta.RDS")

minuscula <- str_to_lower(string_4)

string_4[1]

str_to_title(string_4)

# Nos quedamos con los primeros twits
primeros_twits <- twits$full_text[1:5]


primeros_twits[1]

# Split por cada palabra
twits_split <- str_split(primeros_twits, pattern= " ")

palabra <-  twits_split[[1]][7]

str_length(palabra)

str_sub(palabra, 1,3)

# Reemplazar # por espacio
str_replace(primeros_twits[3], pattern="#", replacement = " ")

# Extrar un patrón
str_extract(string= primeros_twits, pattern="Scaloneta")

primeros_twits[2] = str_to_title(primeros_twits[2])

str_extract(string= primeros_twits, pattern="Scaloneta")

primeros_twits[5] = str_to_title(primeros_twits[5])

primeros_twits

# Detectar un patrón
str_detect(primeros_twits, pattern= "ARGENTINA")

# Detectar y filtrar
messi <- twits %>% 
  filter(str_detect(string = text, pattern= "(M|m)essi"))

messi

# Detectar y filtrar con una palabra que empieza
messi_inicio <- twits %>% 
  filter(str_detect(text, "^Messi"))

getwd()
twits <- readRDS("scaloneta.RDS")

rm(twits)

texto <- unlist(twits$text)
texto <- as.data.frame(texto)

messi_inicio <- texto %>% 
  filter(str_detect(texto, "^Messi"))


# Detectar y filtrar con una palabra que termina el twit
messi_final <- twits %>% 
  filter(str_detect(text, "Messi$"))


twits_text <- twits %>% 
  select(text)

library(tidyverse)

tokens <- twits_text %>% 
  unnest_tokens(input= text, output = word) %>% 
  count(word, sort=TRUE)
  
# Crear expresión regular
hashtag_mencion <- "(@|#)([^ ]*)"

twits <- twits %>% 
  select(text)

# Reemplazar los caracteres de la expresión regular por espacio
twits_2 <- twits %>% 
  mutate(text= str_replace_all(text, pattern= hashtag_mencion, replacement=''))

# Reemplazar las urls
urls <- rx() %>% 
  rx_find("http") %>% 
  rx_anything_but(" ")

urls

twits_2 <- twits_2 %>% 
  mutate(text= str_replace_all(string= text, pattern= urls, replacement=''))

# Pasar a minúsculas
twits_2 <- twits_2 %>% 
  mutate(text = str_to_lower(text))

# Eliminar los dígitos
twits_2 <- twits_2 %>% 
  mutate(text= str_replace_all(text, "[[:digit:]]", ""))

# Cargar stop words
stop_words <- read.delim('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/stop_words.csv')

# Realizar anti join con la lista de palabras y contar las palabras
twits_3 <- twits_2 %>% 
  unnest_tokens(input= text, output = word) %>% 
  na.omit() %>% 
  anti_join(stop_words) %>% 
  count(word, sort= TRUE)

twits_3

# Eliminar la primera palabra 
twits_3 <- twits_3 %>% 
  slice(-1)

twits_3

#Crear nube de palabras
nube <- wordcloud2(twits_3)

# Guardar la nube de palabras
saveWidget(nube, "nube_scaloneta.html", selfcontained = F)



























