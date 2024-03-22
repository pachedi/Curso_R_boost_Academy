
library(tidyverse)
library(openxlsx)

# Condicional if
# El condicional "if" se utiliza justamente para dar una orden al programa
# SOLAMENTE en el caso de que se cumpla una condición.
# ejemplo

curso_a <- 2
curso_b <- 3

total <- curso_a + curso_b

if(total > 10) {
  print('El curso marcha bien')
} 

# A su vez, se puede agregar el condicional 'else if' para agregar nuevas condiciones
# en caso de que sea necesario:
# Nota: se pueden agregar tantos 'else if' como sean necesarios.

if(total< 5){
  'Hay que poner mas trabajo'
} else if( total > 4){
  'Esta mal pero no tan mal' }

# Finalmente, se utiliza el condiconal 'else' para referirse a todos los demás
# resultados posibles:

if(total< 5){
  'Hay que poner mas trabajo'
} else if( total > 4){
  'Esta mal pero no tan mal'
} else {'Vamos bien'}

# Loops.
# Los loops sirven para realizar acciones de manera repetitiva sobre elementos de una lista
# Ejemplo. Vamos a crear una lista e imprimir los cuadrados de cada número

lista <- c(1:10)

for(elemento in lista){
  print(elemento^2)
}

# Probemos el loop con strings. En este caso, R va a trabajar con los índices
# de la lista, es por este motivo que tenemos que explicitar cuantas veces
# queremos que repita la accion.

nombres <- c('Carlos', 'Maria', 'Alberto', 'Romina', 'Marta', 'Walter')

for(nombre in 1:length(nombres)){
  print(paste(nombres[nombre], 'es parte de la lista de invitadxs'))
}

# Ahora, supongamos que tenemos una lista de invitados y sus edades
# Solo pueden entrar los mayorxs de 18 años.
# Podemos combinar el if con el loop:

edades <-  c(11,12,18,21,35,60)

nombres_df <- as.data.frame(nombres)
edades_df <- as.data.frame(edades)

n_y_e <- cbind(nombres_df,edades_df)

for(i in 1:nrow(n_y_e)){
  if(n_y_e$edades[i] >= 18){
    print(paste('Le invitadx', n_y_e$nombres[i], 'está habilitadx'))
  } else{print(paste('Le invitadx', n_y_e$nombres[i], ' *NO* está habilitadx'))}
} 

# Ahora bien, este resultado es un print de pantalla. ¿Qué pasa si quiero crear un
# data frame con este loop?
# Tenemos que crear una lista vacía y para cada resultado, agregarlo a esa lista y luego 
# convertirla en un data frame.

lista_de_invitadxs <- c()
for(i in 1:nrow(n_y_e)){
  if(n_y_e$edades[i] >= 18){
    print(paste('Le invitadx', n_y_e$nombres[i], 'está habilitadx'))
    lista_de_invitadxs <- append(lista_de_invitadxs,n_y_e$nombres[i])
  } else{print(paste('Le invitadx', n_y_e$nombres[i], ' *NO* está habilitadx'))}
} 

lista_df <- as.data.frame(lista_de_invitadxs)

lista_df <- lista_df %>% 
  rename('Invitadxs habilitadxs'= 1 )

# Puedo guardar la lista en un excel
write.xlsx(lista_df, 'lista_de_invitados.xlsx')

# Funciones
# las funciones sirven para automatizar acciones que se repiten
# Podemos crear las funciones que necesitemos con distintos tipos de complejidad
# Lo importante es seguir la estructura de R

suma <- function(valor1, valor2){
  return(valor1 + valor2)
}
suma(1,3)

# Tambien se puede hacer el manejo de errores. ¿Qué pasa si el usuario introduce un 
# valor no numerico?

suma(1,'a')

# El usuario recibirá un error poco 'amigable', es por este motivo que podemos
# hacer un manejo de errores e ingresar un mensaje de error:

suma <- function(valor1, valor2){
  assertthat::assert_that(is.numeric(valor1),
                          msg = "Ingrese un valor numérico")
  assertthat::assert_that(is.numeric(valor2),
                          msg = "Ingrese un valor numérico")
  return(valor1 + valor2)
}
suma(1,'a')

# De esta manera el usuario comprendera cual es el problema por el cual la 
# funcion no realiza su tarea

# Tambien se puede agregar advertencias, es decir, valores que pueden afectar 
# el resultado de alguna manera pero que no frenan su tarea. Un ejemplo es la
# existencia de 0 en la suma:

suma <- function(valor1, valor2){
  assertthat::assert_that(is.numeric(valor1) & is.numeric(valor2),
                          msg = "Ingrese un valor numérico")
  if(any(valor1==0 | valor2 == 0 )){
    warning("Hay un cero en tu vector, no lo tomo en cuenta para el calculo")
  }  
  return(valor1 + valor2)  
}
# Podemos probar todas las posibilidades
suma(1,'a')
suma('a',1)
suma(0,1)
suma(1,0)
suma(2,3)


# Ciclos indefinidos. Estos ciclos estan representados con el operador 'while'
# el cual como lo indica su nombre, va a suceder una accion 'mientras' exista una 
# condicion.
# Hagamos un ejemplo siguiendo con la fiesta
# Hay personas que quieren entrar a un evento en el que hay aforo para 10 personas

aforo <- 0
while(aforo < 10){
  aforo <- aforo + 1
  print(aforo)
  if(aforo == 10){
    print('aforo completo')
  }
}












