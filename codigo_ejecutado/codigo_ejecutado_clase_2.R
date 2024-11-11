

a_factorear <- c(7,5,7,5,5,2)

etiquetado <- factor(a_factorear,
                     levels = c(2, 5, 7),
                     labels = c("Varon", "Mujer", "No binario"))

print(etiquetado)


# Valores NA


con_na <- c(2,3,1,NA, 20,5, NA)

con_na[4]

is.na(con_na[4])

is.na(con_na)

which(is.na(con_na))

which(!is.na(con_na))

sum(is.na(con_na))

sin_na <- na.omit(con_na)

print(sin_na)

con_na[is.na(con_na)] <- 0

print(con_na)

?na.omit

## Listas

a <- c(20:30)

b <- c("un", "nuevo", "string")

nueva_lista <- list(100, "hello world", a, b)

#View(nueva_lista)

nueva_lista[[3]][1]

nueva_lista[[4]][3]


###

nombre <- "Diego"


print(paste("Mi nombre es", nombre))

print(paste("Mi nombre es", nombre, sep=": "))

print(paste0("Mi nombre es ", nombre))


# Ingreso de datos por consola

nombre <- readline("¿Cuál es tu nombre? ")

print(paste("Hola", nombre, ":)"))

### Condicionales


grupo_a <- 20
grupo_b <- 30
aforo <- 20

if(grupo_a + grupo_b < aforo){
  
  print("Pueden entrar")
  
} else if(grupo_a + grupo_b == aforo ){
  
  print("Aforo completo, no entra nadie más")
  
} else {
  
  print("Aforo excedido, no pueden pasar")
  
  }

### Ciclos definidos (for)

nombres_invitados <- c("Maria", "Carlos", "Marta", "Roberto", "Walter", "Diego","Zoe")

length(nombres_invitados)

for (i in nombres_invitados){
  
  print(i)
  
}


for(i in 1:length(nombres_invitados)){
  
  print(nombres_invitados[i])
  
}

for(nombre in 1:length(nombres_invitados)){
  
  print(paste(nombres_invitados[nombre], "está en la lista de invitados"))
  
}

nombres_invitados <- c("Maria", "Carlos", "Marta", "Roberto", "Walter", "Diego","Zoe")
edades <- c(20, 10, 5, 50, 80, 3, 25)

nombres_edades <- data.frame(nombres_invitados, edades)


length(nombres_edades)

nrow(nombres_edades)


nombres_edades$edades[1]
nombres_edades$edades[2]
nombres_edades$edades[3]
nombres_edades$edades[4]


for(i in 1:nrow(nombres_edades)){
  
  if(nombres_edades$edades[i] >= 18){
    
    print("puede ingresar")
  } else{
    
    print("no puede ingresar")
    
  }
  
}

nombres_edades

nombres_edades["edades"][[1]][2]

for(i in 1:nrow(nombres_edades)){
  
  if(nombres_edades$edades[i] >= 18){
    
    print(paste(nombres_edades$nombres_invitados[i],  "puede ingresar"))
    
  } else{
    
    print(paste(nombres_edades$nombres_invitados[i],  "no puede ingresar"))
    
  }
  
}

# Ciclo indefinido while

numero <- 0

while(numero < 20){
  
  numero <- numero + 1
  print(numero)
  if(numero == 15){
    
    break
  }
  
}

numero <- 0
while(numero < 20){
  
  numero <- numero + 1
  
  if(numero == 15){
    
    print("es numero 15 no lo necesito")
    next
  }
  print(numero)
}

# Funciones

suma <- function(numero1, numero2){
  
  resultado <- numero1 + numero2
  
  return(resultado)
  
}

suma(1,10)

suma("1", 20)

install.packages("assertthat")
library(assertthat)

suma <- function(numero1, numero2){
  
  assert_that((is.numeric(numero1) & is.numeric(numero2)),
              msg = "Ingrese un valor numerico")
  
  #assert_that((),
  #            msg = "Ingrese un valor numerico")
  
  resultado <- numero1 + numero2
  
  return(resultado)
  
}


suma( 10, 1)











