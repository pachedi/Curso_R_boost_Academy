source("funcion_contagios.R")

ciudad <- readline("Ingrese el nombre de la ciudad: ")
poblacion <- readline("Ingrese la cantidad de población: ")
contagios <- readline("Ingrese la cantidad de contagios: ")

cada_100_mil(ciudad, poblacion, contagios)



