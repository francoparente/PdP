class Maestro {
  var property habilidad

  method esGroso(){
    return habilidad > 5 && self.poder() > 1000
  }
}
class MaestroAgua inherits Maestro{
  method poder(){
    return habilidad*100
  }
  method esPeligroso(){
    return self.poder() > 3000
  }
}
class MaestroFuego inherits Maestro{
  var rabia
  var locura

  method poder(){
    return rabia/locura
  }
}
class MaestroSangre inherits MaestroAgua {
  override method esPeligroso(){
    return true
  }
  override method poder(){
    return super()*2
  }
}

object aang inherits Maestro(habilidad=100) {
  var mascotas = []
  
  method mascota(nuevaMascota){
    mascotas.add(nuevaMascota)
  }
  method poder(){
    return mascotas.sum({mascota => mascota.poder() * self.habilidad()})
  }
}

class Mascota{
  var property poder
}
const appa = new Mascota(poder=150)
const momo = new Mascota(poder=15)