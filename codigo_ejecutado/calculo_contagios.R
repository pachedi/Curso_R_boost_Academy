cada_100_mil <- function(valor, poblacion, nombre){
  
  valor <- as.numeric(valor)
  poblacion <- as.numeric(poblacion)
  resultado <- round(valor / poblacion * 100000, 2)
  mensaje_final <- paste(nombre, "tiene", resultado, "contagios cada 100 mil habitantes")
  return(mensaje_final)
  
}

suma <- function(numero1, numero2){
  
  assert_that((is.numeric(numero1) & is.numeric(numero2)),
              msg = "Ingrese un valor numerico")
  
  #assert_that((),
  #            msg = "Ingrese un valor numerico")
  
  resultado <- numero1 + numero2
  
  return(resultado)
  
}

