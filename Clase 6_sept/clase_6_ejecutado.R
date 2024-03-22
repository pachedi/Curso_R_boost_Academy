
library(tidyverse)

#a <- "Diego"

# Esto no funcion
#print("Mi nombre es: ", a)

#paste("Mi nombre es:", a)

# Ingresar información por consola
nombre <- readline("¿Cómo te llamás?")

# Concatenar strings
print(paste("hola", nombre, ":)"))


grupo_a <- 10
grupo_b <- 10
aforo <- 10

# Condicionales
if(grupo_a + grupo_b < aforo){
  
  print("Pueden pasar")
  
} else if(grupo_a + grupo_b == aforo){
  
  print("Aforo completo, no entra nadie más")
  
} else{
  
  print("Aforo excedido") 
}


nombres <- c("Carlos", "Maria", "Marta", "Jose","Diego")

print(nombres[1])
print(nombres[2])
print(nombres[3])
print(nombres[4])
print(nombres[5])

length(nombres)

# Iteración for
for(i in 1:length(nombres)){
  
  print(nombres[i])
  
}

nombres <- c("Carlos", "Maria", "Marta", "Jose","Diego")
edad <- c(20, 5, 30, 12, 45)

for(i in 1:length(nombres)){
  
  print(paste(nombres[i] , "está en la lista de invitados"))
  
}

n_e <- data.frame(nombres,edad)
n_e


ingresan <- c()
for(i in 1:nrow(n_e)){
  
  if(n_e$edad[i] >= 18){
    
    print(paste("El invitado", n_e$nombres[i], "puede entrar"))
    ingresan <- append(ingresan, n_e$nombres[i])
    
  } else {
    
    print(paste("El invitado", n_e$nombres[i], "no puede entrar"))
    
  }
}

ingresan

#n_e$edad[3]

numero <- 0

# Ciclio indefinido
while(numero < 50){
  
  numero <- numero + 1
  
  if(numero %in% c(20:25)){
    
    next
  }  else if(numero == 48){
    
    break
  }
  print(numero)
}

#install.packages("assertthat")
library(assertthat)

# Crear una función
suma <- function(num1, num2){
  
  assert_that(is.numeric(num1) & is.numeric(num2),
              msg= "Ingrese un valor numérico")  
  #assert_that(is.numeric(num2),
  #            msg= "Ingrese un valor numérico")
  
  resultado <- num1 + num2
  return(resultado)
}


suma(4, 100)















