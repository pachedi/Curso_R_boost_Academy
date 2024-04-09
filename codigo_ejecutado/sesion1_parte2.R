
#nombre <- "Diego"

#print("Mi nombre es: ", nombre)

#paste0("Mi nombre es:", nombre)

# Cargar información a través de la consola
nombre <- readline("¿Cuál es tu nombre? ")

# Concatenar strings
print(paste("Hola", nombre, ":)"))

# Condicionales if, else, if else
grupo_a <- 10
grupo_b <- 11

aforo <- 20

if(grupo_a + grupo_b < aforo){
  
  print("Pueden entrar")
  
} else if(grupo_a + grupo_b == aforo){
  
  print("El lugar está lleno, no entra nadie más")
  
} else{
  
  print("No pueden pasar, superan el aforo")
  
}

# length 

nombres <- c("Marta", "Diego", "Maria", "Jose")

length(nombres)

print(nombres[1])
print(nombres[2])
print(nombres[3])
print(nombres[4])
print(nombres[5])

# Ciclos definidos

for(i in 1:length(nombres)){
  
  print(paste(nombres[i], "está en la lista de invitados"))
  
}

nombres <- c("Marta", "Diego", "Maria", "Jose", "Roberto", "Alberto")
edades <- c(15, 18, 9, 40, 50, 12)

grilla <- data.frame(nombres, edades)

grilla

grilla$edades[1]
grilla$edades[2]


length(grilla)

nrow(grilla)


lista_de_invitados <- c()

for(i in 1:nrow(grilla)){
  
  if(grilla$edades[i] >= 18 ){
    
    print(paste(grilla$nombres[i],  "puede pasar"))
    lista_de_invitados <- append(lista_de_invitados,grilla$nombres[i])
    
  }else{
    
    print(paste(grilla$nombres[i],  "no puede pasar"))
    
  }
} 

print(lista_de_invitados)

# Ciclos indefinidos
contador <- 0

while(contador < 50){
  
  contador <- contador + 1
  
  if(contador == 25){
    
    next
  }
  
  print(contador)

}

while(contador < 50){
  
  contador <- contador + 1
  
  if(contador == 40){
    
    break
  }
  
  print(contador)
  
}

# Funciones
suma <- function(num1, num2){
  
  resultado <- num1 + num2
  
  return(resultado)
  
}

suma(10, 2)

resultado_suma <- suma("a", 100)

resultado_suma

#install.packages("assertthat")
library(assertthat)

suma <- function(num1, num2){
  
  
  assert_that(is.numeric(num1),
              msg= "Ingrese un valor numérico")
  
  assert_that(is.numeric(num2),
              msg= "Ingrese un valor numérico")
  
  resultado <- num1 + num2
  
  return(resultado)
  
}

suma( 10, "B")





