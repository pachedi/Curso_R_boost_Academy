library(stringr)
library(tidyverse)
library(RVerbalExpressions)
library(wordcloud2)
library(tidytext)
library(webshot)
library("htmlwidgets")

string <- "esto es un string"

# Largo de un string
str_length(string)

string_2 <- "Houston, tenemos un problema"

# sustracción de un fragmento de un string
str_sub(string_2, 1, 7)

# sustracción empezando por el final
str_sub(string_2, -8, -1)

# Esto no funciona
#str_sub(string_2, -1, -8)

string_3 <- c("esto ", "  es", " muy ", " molesto")

# Eliminación de espacios por izquierda
str_trim(string_3, side= "left")

# Eliminación de espacios por derecha
str_trim(string_3, side= "right")

# Eliminación de espacios por ambos lados
str_trim(string_3, side= "both")

palabra <- "esto es un string "

derecha <- "right"

?str_trim

str_trim(palabra, side= derecha)

# Concatenar cadenas de caracteres
Municipios <- c("Quilmes", "Vicente lopez", 
                "Ituzaingo", "Moron", "San Isidro",
                "Avellaneda")

provincia <- "Buenos Aires"

str_c(Municipios, provincia, sep= "-")

provincia <- "LA RiojA"

# Pasar a minuscula
str_to_lower(provincia)

# Pasar a mayúsculas
str_to_upper(provincia)

# Cargar base en .RDS
twits <- readRDS("scaloneta.RDS")

getwd()

class(twits)

# Seleccionar la columna que tiene el texto
twits <- twits %>% 
  select(full_text)

# Seleccionar los 1eros 5 twits
primeros_twits <- twits$full_text[1:5]

primeros_twits
# Separar un texto por palabras
separacion <- str_split(primeros_twits, pattern= " ")

separacion[[3]][11]

primeros_twits

# Eliminar los #
str_replace(primeros_twits, pattern="#", 
                          replacement = "")

# Eliminar # y @
str_replace(primeros_twits, pattern="(@|#)", 
            replacement = "")

# Detectar patrones
str_detect(primeros_twits, pattern="Scaloneta|scaloneta|SCALONETA")


messi <- twits %>% 
  filter(str_detect(full_text, pattern= "Messi"))

messi <- twits %>% 
  filter(str_detect(full_text, pattern= "Messi|messi"))

#### DEBATE PRESIDENCIAL

base <- read.delim("transcripcion_debate.txt",
                   header= FALSE)

# Crear columna nueva vacia
base2 <- base %>% 
  mutate(oradores = NA)


base2 <- base2 %>% 
  rename(texto = 1)

colnames(base2)

# Contar palabras y filtrar las filas que tienen
# 2 palabras o menos (nombre y apellido)
nombres <- base2 %>% 
  filter(str_count(texto, "\\w+") <=2 )

str_count(base2$texto[11], "\\w+")

# identificar cómo están nombrados los oradores
nombres <- unique(nombres$texto)

nombres

# Normalizar nombres
base2 <- base2 %>% 
  mutate(texto= str_trim(texto, side= "both"))

base2 <- base2 %>% 
  select(-3)

base2 <- base2 %>% 
  mutate(texto = str_replace_all(texto, "Myriam Bregman:", "Bregman:"),
         texto = str_replace_all(texto, "Juan Schiaretti:", "Schiaretti:"),
         texto = str_replace_all(texto, "Javier Milei:", "Milei:"),
         texto = str_replace_all(texto, "Patricia Bullrich:", "Bullrich:"),
         texto = str_replace_all(texto, "Sergio Massa:", "Massa:"),
         texto = str_replace_all(texto, "Moderador:", "Moderadores:"))

# Pasar los oradores a la columna correspondiente

base2 <- base2 %>% 
  mutate(oradores = case_when(texto == "Bregman:"~ "Bregman",
                              texto == "Schiaretti:" ~"Schiaretti",
                              texto == "Milei:" ~ "Milei",
                              texto == "Bullrich:" ~ "Bullrich",
                              texto == "Massa:" ~ "Massa",
                              texto == "Moderadores:" ~ "Moderadores")
         )


# llenar la columna oradores
base3 <- base2 %>% 
  fill(oradores, .direction= "down")

# Filtrar por orador
milei <- base3 %>% 
  filter(oradores == "Milei")

# Eliminar columna oradores
milei <- milei %>% 
  select(-2)

# Eliminar las filas que indican el orador
milei <- milei %>% 
  mutate(texto = str_replace_all(texto, "Milei:", ""))

# pasa a minuscula
milei <- milei %>% 
  mutate(texto = str_to_lower(texto))

# Eliminar los numeros
milei <- milei  %>% 
  mutate(texto = str_replace_all(texto, "[[:digit:]]", ''))

# cargar stop words
stop_words <- read.delim('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/stop_words.csv')

# Crear base tokenizada
unigram <- milei %>% 
  unnest_tokens(input= texto, output= word) %>% 
  na.omit() %>% 
  anti_join(stop_words)

# Contar palabras y ordenar por frecuencia
unigram <- unigram %>% 
  count(word, sort = TRUE)

# Crear nube de palabras
wordcloud2(unigram)











