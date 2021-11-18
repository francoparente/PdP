object tom {
  var posicion = 0
  var energia = 80
  
  method velocidad(){
    return 5+energia/10
  }
  method esMasVeloz(raton) {
    return self.velocidad() > raton.velocidad()
  }
  method correrA(raton) {
    energia = energia - 0.5*self.velocidad()*(raton.posicion()-posicion)
    posicion = raton.posicion()
  }
}
//------------------------------------------------------
object jerry {
  var posicion = 10
  var peso = 3
  
  method velocidad(){
    return 10 - peso
  }
  method posicion(){
    return posicion
  }
}
//------------------------------------------------------
object robotRaton {
  var posicion = 12
  const velocidad = 8
  
  method velocidad(){
    return velocidad
  }
  method posicion(){
    return posicion
  }
}