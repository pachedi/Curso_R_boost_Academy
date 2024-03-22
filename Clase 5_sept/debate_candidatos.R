library(stringr)
library(tidyverse)
library(wordcloud2)
library(tidytext)
library(stringi)

nube_candidato <- function(candidato){

  base <- read.delim("transcripcion_debate.txt",
                     header= F) %>% 
    rename(txt = 1)
  
  base2 <- base %>% 
    mutate(Orador = NA)
  
  str_count(base2$txt[2], "\\w+")
  
  nombres <- base2 %>% 
    filter(str_count(txt, "\\w+") <=2)
  
  nombres <- unique(nombres$txt)
  
  nombres
  
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
  
  base2$txt[220] = paste("La educación", base2$txt[221])
  
  base2 <- base2 %>% 
    slice(-221)
  
  base3 <- base2 %>% 
    fill(Orador, .direction = "down") 
  
  sum(is.na(base3$Orador))
  
  bregman <- base3 %>% 
    filter(Orador== candidato)
  
  nombre <- paste0(candidato, ":")
  
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
  
  print(wordcloud2(bregman_count))
  
}
