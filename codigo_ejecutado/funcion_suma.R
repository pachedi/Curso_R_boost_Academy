suma <- function(numero1, numero2){
  
  assert_that((is.numeric(numero1) & is.numeric(numero2)),
              msg = "Ingrese un valor numerico")
  
  #assert_that((),
  #            msg = "Ingrese un valor numerico")
  
  resultado <- numero1 + numero2
  
  return(resultado)
  
}