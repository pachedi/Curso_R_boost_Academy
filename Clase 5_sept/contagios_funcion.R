cada_100_mil <- function(ciudad, poblacion, contagios){
  
  
  poblacion <- as.numeric(poblacion)
  contagios <- as.numeric(contagios)
  resultado <- round(contagios / poblacion * 100000,2)
  
  print(paste(ciudad, "tiene" , resultado, "contagios cada 100 mil habitantes"))
  
}