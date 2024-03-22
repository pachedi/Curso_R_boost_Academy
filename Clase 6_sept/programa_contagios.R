cada_100_mil <- function(ciudad, poblacion, contagios){


  poblacion <- as.numeric(poblacion)
  contagios <- as.numeric(contagios)
  resultado <- round(contagios / poblacion * 100000,2)

  print(paste(ciudad, "tiene" , resultado, "contagios cada 100 mil habitantes"))

}

#cada_100_mil("Buenos Aires", 20000000, 123000)

#source("contagios_funcion.R")

ciudad <- readline("¿Cuál es el nombre de la ciudad? ")
poblacion <- readline("¿Qué cantidad de población tiene? ")
contagios <- readline("¿Cuál es la cantidad de contagios? ")

cada_100_mil(ciudad, poblacion, contagios)



