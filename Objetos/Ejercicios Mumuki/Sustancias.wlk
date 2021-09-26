object logan {
  var inercia = 5
  var peso = 70
  var sustanciaConsumida
  var cantidadConsumida
  var rendimiento
  
  method consumir(cantidad, sustancia) {
    sustanciaConsumida = sustancia
    cantidadConsumida = cantidad
    rendimiento = sustanciaConsumida.rendimiento()
  }
  method fuerza(){
    return sustanciaConsumida.rendimiento()*inercia*peso
  }
  method cantidadConsumida(){
    return cantidadConsumida
  }
}

object clo2 {
  method rendimiento() {
    return 0.9 ** logan.cantidadConsumida()
  }
}

object terere {
  method rendimiento() {
    return 1.max(0.1*logan.cantidadConsumida())
  }
}

object cianuro {
  method rendimiento() {
    return 0
  }
}