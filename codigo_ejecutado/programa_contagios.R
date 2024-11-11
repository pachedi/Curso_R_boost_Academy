source("calculo_contagios.R")

nombre <- readline("Indique el nombre de la ciudad: ")
contagios <- readline("Indique la cantidad de contagios: ")
poblacion <- readline("Indique la poblacion del lugar: ")


cada_100_mil(contagios, poblacion, nombre)

revertido <- con_na
sin_na[attr(sin_na, "na.action")] <- NA

print(revertido)