
library(tidyverse)

nombre <- "Carlos"

# Error
print("Mi nombre es" , nombre)

print(paste("Mi nombre es", nombre, sep= ""))

print(paste0("Mi nombre es", nombre))

nombre <- readline("¿Cuál es tu nombre? ")

print(paste("Hola", nombre, ":)"))

### Condicionales

grupo_a <- 10
grupo_b <- 5

aforo <- 10

if(grupo_a + grupo_b < aforo){
  
  print("Pueden entrar")
  
} else {
  
  print("Aforo excedido")
  
}

###

grupo_a <- 10
grupo_b <- 5
aforo <- 5

if(grupo_a + grupo_b < aforo){
  
  print("Pueden entrar")
  
} else if(grupo_a + grupo_b == aforo){
  
  print("No entra nadie más")
  
} else {
  
  print("Aforo excedido")
  
}

nombres <- c("María", "Carlos","José","Marta",
             "Diego")

length(nombres)

print(nombres[1])
print(nombres[2])
print(nombres[3])
print(nombres[4])
print(nombres[5])

nombres <- c("María", "Carlos","José","Marta",
             "Diego", "Ramiro")

for(i in 1:5){
  
  print(nombres[i])
  
}

for(i in 1:length(nombres)){
  
  print(paste(nombres[i], "está en la lista"))
  
}

nombres <- c("María", "Carlos","José","Marta",
             "Diego", "Ramiro")

edades <- c(10, 20, 50, 7, 15, 60)

nom_ed <- data.frame(nombres, edades)

nom_ed

nom_ed$edades[2]

for(i in 1:nrow(nom_ed)){
  if(nom_ed$edades[i] >= 18){
    print("Puede pasar")
  } else {
  print("Es menor, no puede pasar")
  }
}

for(i in 1:nrow(nom_ed)){
  if(nom_ed$edades[i] >= 18){
    print(paste(nom_ed$nombres[i],"puede pasar"))
  } else {
    print(paste(nom_ed$nombres[i], "es menor, no puede pasar"))
  }
}
nom_ed

lista_invitados <- c()

for(i in 1:nrow(nom_ed)){
  if(nom_ed$edades[i] >= 18){
    print(paste(nom_ed$nombres[i],"puede pasar"))
    lista_invitados <- append(lista_invitados, nom_ed$nombres[i])
  } else {
    print(paste(nom_ed$nombres[i], "es menor, no puede pasar"))
  }
}

lista_invitados

numero <- 0

while(numero < 50){

  numero <- numero + 1
  print(numero)
}

numero <- 0
while(numero < 50){
  
  numero <- numero + 1
  print(numero)
  
  if(numero == 39){
    break
  }
}


suma <- function(num1, num2){
  
  resultado = num1 + num2
  return(resultado)
  
}

suma(10, 20)

install.packages("assertthat")
library(assertthat)

suma <- function(num1, num2){
  
  assert_that(is.numeric(num1),
              msg= "Ingrese un valor numérico")
  assert_that(is.numeric(num2),
              msg= "Ingrese un valor numérico")
  resultado = num1 + num2
  return(resultado)
  
}
suma(1, "3")





