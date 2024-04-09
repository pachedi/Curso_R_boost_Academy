cada_100_mil <- function(valor, poblacion, nombre){
  
  
  valor <- as.numeric(valor)
  poblacion <- as.numeric(poblacion)
  resultado <- valor / poblacion * 100000
  
  print(paste(nombre, "tiene", resultado, "contagios cada 100 mil hab"))
  
}

valor <- readline("¿Cuántos contagios hay en el lugar? ")
poblacion <- readline("¿Cuál es la población del lugar? ")
nombre <- readline("¿Cuál es el nombre de la ciudad? ")

cada_100_mil(valor, poblacion, nombre)





