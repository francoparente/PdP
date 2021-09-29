class Zombi {
  var salud = 100

  method sabeCorrer(){
    return false
  }
  method salud(){
    return salud
  }
  method recibirDanio(puntos){
    salud = 0.max(salud-puntos*2)
  }
  method vivo(){
    return salud > 0
  }
}

const bouba = new Zombi()
const kiki = new Zombi()

class Sobreviviente {
  var energia
  
  method atacar(zombi){
    zombi.recibirDanio(0.1*energia)
  }
  method energia(){
    return energia
  }
  method energia(cantidad){
    energia = cantidad
  }
}

const juliana = new Sobreviviente(energia = 100)
const anastasia = new Sobreviviente(energia = 150)