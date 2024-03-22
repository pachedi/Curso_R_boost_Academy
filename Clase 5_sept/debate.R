library(stringr)
library(tidyverse)
library(RVerbalExpressions)
library(wordcloud2)
library(tidytext)
library(webshot)
library("htmlwidgets")
library(stringi)

base <- read.delim("transcripcion_debate.txt",
                   header= F) %>% 
  rename(txt = 1)

# bregman <- grep("^Bregman:", base$V1)
# schiaretti <- grep("^Schiaretti:", base$V1)
# milei <- grep("^Milei:", base$V1)
# bullshit <- grep("^Bullrich:", base$V1)
# moderadores <- grep("^Moderadores:", base$V1)
# massa <- grep("^Massa", base$V1)

base2 <- base %>% 
  mutate(Orador = NA)


str_count(base2$txt[2], "\\w+")

nombres <- base2 %>% 
  filter(str_count(txt, "\\w+") <=2)

nombres <- unique(nombres$txt)

nombres

# nombres <- c()
# 
# for(i in 1:nrow(base2)){
#   
#   if(str_count(base2$txt[i], '\\w+') <= 2){
#     
#     nombres <- append(nombres, base2$txt[i])
#   }
# }
# 
# nombres = unique(nombres)
# nombres


base2 <- base2 %>% 
  mutate(txt = str_trim(txt, side="both"))

base2 <- base2 %>% 
  mutate(txt = str_replace_all(txt, "Myriam Bregman:", "Bregman:"),
         txt = str_replace_all(txt,"Juan Schiaretti:", "Schiaretti:"),
         txt = str_replace_all(txt, "Patricia Bullrich:", "Bullrich:"),
         txt = str_replace_all(txt, "Sergio Massa:", "Massa:"),
         txt = str_replace_all(txt, "Javier Milei:", "Milei:"),
         txt = str_replace_all(txt, "Moderador:" , "Moderadores:"))

base2 <- base2 %>% 
  mutate(Orador = case_when(txt == "Bregman:" ~ "Bregman",
                             txt == "Milei:" ~ "Milei",
                             txt == "Schiaretti:" ~ "Schiaretti",
                             txt == "Moderadores:" ~ "Moderadores",
                             txt == "Bullrich:" ~ "Bullrich",
                             txt == "Massa:" ~ "Massa"))

nombres <- base2 %>% 
  filter(str_count(txt, "\\w+") <=2)

nombres <- unique(nombres$txt)

nombres

which(base2$txt == "La educación")

base2$txt[220] = paste("La eduacación", base2$txt[221])

base2 <- base2 %>% 
  slice(-221)

# for(i in bregman){
#   
#   base2$Orador[i] = "Bregman"
#   
# }
# 
# for(i in schiaretti){
#   
#   base2$Orador[i] = "Schiaretti"
#   
# }
# 
# for(i in bullshit){
#   
#   base2$Orador[i] = "Bullrich"
#   
# }
# for(i in moderadores){
#   
#   base2$Orador[i] = "Moderadores"
#   
# }
# 
# for(i in milei){
#   
#   base2$Orador[i] = "Milei"
#   
# }
# for(i in massa){
#   
#   base2$Orador[i] = "Massa"
#   
# }


#texto <- as.character(base$V1)

base3 <- base2 %>% 
fill(Orador, .direction = "down") 

bregman <- base3 %>% 
  filter(Orador=="Bregman")

nombre <- "Bregman:"

bregman  <- bregman %>% 
  mutate(txt = str_replace_all(txt, nombre, ''))

bregman <- bregman %>% 
  select(-2)

bregman <- bregman %>% 
  mutate(txt = str_to_lower(txt))

bregman <- bregman %>% 
  mutate(txt = str_replace_all(txt, "[[:digit:]]", ''))

stop_words <- read.delim('https://raw.githubusercontent.com/pachedi/INTRO_R_CS/main/stop_words.csv')

bregman_count <- bregman %>% 
  unnest_tokens(output= word, input= txt, token = "ngrams", n = 1) %>%
  na.omit() %>%  # omitimos las líneas vacías
  anti_join(stop_words)  %>% 
  count(word, sort = TRUE) 

wordcloud2(bregman_count)
