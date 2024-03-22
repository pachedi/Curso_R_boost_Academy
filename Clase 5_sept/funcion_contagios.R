cada_100_mil <- function(ciudad, poblacion, contagios){
  
  poblacion <- as.numeric(poblacion)
  contagios <- as.numeric(contagios)
  
  resultado <- contagios / poblacion * 100000
  
  print(paste(ciudad, "tiene", resultado, "contagios cada 
  100 mil habitantes"))
  
}