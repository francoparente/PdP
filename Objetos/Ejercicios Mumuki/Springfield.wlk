//========================La Region========================
object laRegion {
  var ciudades = [springfield, albuquerque]
  
  method agregarCiudad(ciudad){
    ciudades.add(ciudad)
  }
  method principalCiudadProductora(){
    return ciudades.max({ciudad => ciudad.produccionEnergetica()})
  }
  method principalesCentrales(){
    return ciudades.forEach({ciudad => ciudad.mayorCentral()})
  }  
}
//========================Ciudades========================
object springfield {
  var centrales = [centralNuclear, centralCarbon, centralEolica]
  var necesidad = 1000000
  
  method centralesContaminantes(){
    return centrales.filter({central => central.esContaminante()})
  }
  method necesidadEnergetica(kWh){
    return necesidad = kWh
  }
  method cubreNecesidad(){
    return centrales.sum({central => central.produccionEnergetica()}) > necesidad
  }
  method estaAlHorno(){
    return centrales.all({central => central.esContaminante()})
    || centrales.sum({central => central.produccionEnergetica()}) > necesidad/2
  }
  method produccionEnergetica(){
    return centrales.sum({central => central.produccionEnergetica()})
  }
  method mayorCentral(){
    return centrales.max({central => central.produccionEnergetica()})
  }
}
//-------------------------------------------------------
object albuquerque {
  var centrales = [centralHidroelectrica]
  
  method centralesContaminantes(){
    return true
  }
  method necesidadEnergetica(kWh){
    return true
  }
  method cubreNecesidad(){
    return true
  }
  method estaAlHorno(){
    return false
  }
  method produccionEnergetica(){
    return centrales.sum({central => central.produccionEnergetica()})
  }
  method mayorCentral(){
    return centrales.max({central => central.produccionEnergetica()})
  }
}
//========================Centrales========================
object centralNuclear {
  var varillas = 200
  
  method produccionEnergetica(){
    return 0.1*varillas
  }
  method esContaminante(){
    return varillas>20
  }
}
//-------------------------------------------------------
object centralCarbon {
  var toneladas = 1000
  var riquezaSuelo = 0.9
  
  method produccionEnergetica(){
    return 0.5+toneladas*riquezaSuelo
  }
  method esContaminante(){
    return true
  }
}
//-------------------------------------------------------
object centralEolica {
  var turbinas = 1
  var velocidadViento = 10
  
  method produccionEnergetica(){
    return 0.2*turbinas*velocidadViento
  }
  method esContaminante(){
    return false
  }
}
//-------------------------------------------------------
object centralHidroelectrica {  
  var caudal = 150
  
  method produccionEnergetica(){
    return caudal*2000000
  }
  method esContaminante(){
    return false
  }
}