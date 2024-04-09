
#install.packages(c("stringr", "RVerbalExpressions", "wordcloud2",
#                   "tidytext"))

library(stringr)
library(tidyverse)
library(RVerbalExpressions)
library(wordcloud2)
library(tidytext)

string <- "Esto es un string"

str_length(string)

string_2 <- "Houston, tenemos un problema"

str_sub(string_2, start = 1, end = 7)

str_sub(string_2, start = -8, end= -1)

string_3 <- c("hola ", " esto", " es ", "problematico ")

str_trim(string_3, side="left")
str_trim(string_3, side="right")
str_trim(string_3, side="both")

split <- str_split(string_2, pattern=",")

split[[1]][1]

sufijo <- "Argentina"

provincias <- c("Buenos Aires", "Capital", "Córdoba", "Santa Fe")

str_c(provincias, sufijo, sep="/")

string_4 <- "gAlIcIA"

str_to_upper(string_4)

str_to_lower(string_4)

twits <- readRDS("scaloneta.RDS")


primeros_twits <- twits$text[1:10]

primeros_twits

lista_twits <- str_split(primeros_twits, pattern = " ")

lista_twits[[3]][11]

primeros_twits

str_replace(primeros_twits, pattern = "@", replacement = "")

str_replace(primeros_twits, pattern = "#", replacement = "")

str_extract(primeros_twits, pattern="Scaloneta")

str_detect(primeros_twits, pattern = "Scaloneta")

minuscula <- str_to_lower(primeros_twits)

minuscula
sum(str_detect(minuscula, pattern = "scaloneta"))

twits_messi <- twits %>% 
  filter(str_detect(string = text, pattern= "Messi"))

twits_messi <- twits %>% 
  filter(str_detect(string = text, pattern= "Messi|messi|MESSI")) %>% 
  select(text)

head(twits_messi)

inicio <- twits %>% 
  filter(str_detect(string = text, pattern= "^#Scaloneta"))

inicio$text[2]

final <- twits %>% 
  select(text) %>% 
  filter(str_detect(text, pattern= "#Scaloneta$"))

final$text[1]

final$text[10]


tokens <- twits %>% 
  select(text) %>% 
  unnest_tokens(input=text, output = word)

tokens_2 <- twits %>% 
  select(text) %>% 
  unnest_tokens(input = text, output = word) %>% 
  count(word, sort=TRUE)

head(tokens_2, 10)

hashtag_arroba <- "(@|#)([^ ]*)"

twits <- twits %>% 
  select(text)

twits_2 <- twits %>% 
  mutate(text = str_replace_all(text, hashtag_arroba, ""))

http <- rx() %>% 
  rx_find("http") %>% 
  rx_anything_but(" ")


http

twits_2 <- twits_2 %>% 
  mutate(text = str_replace_all(string = text, pattern= http,replacement= ""))

twits_2 <- twits_2 %>% 
  mutate(text = str_to_lower(text))

twits_2 <- twits_2 %>% 
  mutate(text = str_replace_all(string = text, pattern= "[[:digit:]]", 
                                replacement = ""))

stop_words <- read.delim('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/stop_words.csv')

rm(stop_words)
a <- stop_words

?stop_words

unigrams <- twits_2 %>% 
  unnest_tokens(input= text, output= word) %>% 
  na.omit() %>% 
  anti_join(stop_words) %>% 
  count(word, sort= T)

unigram_recorte <- unigrams %>% 
  slice(2:200)

wordcloud2(unigram_recorte)

nube <- wordcloud2(unigrams)
library(webshot)
library("htmlwidgets")
saveWidget(nube,"nube.html", selfcontained = FALSE)




