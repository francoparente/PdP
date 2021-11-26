class Expedicion {
	const objetivos
	var vikingos = []
	method cantInvasores() = vikingos.size()
	
	method valeLaPena(cantInvasores) = objetivos.all({obj => obj.valeLaPena()})
	
	method subirVikingo(vikingo) {
		if(not vikingo.puedeSubirAExpedicion(self))
			throw new DomainException(message = "El vikingo no puede subir a la expedición")
		vikingos++
	}
	
	method realizarExpedicion() {
		objetivos.forEach({obj => obj.serInvadidaPor(self)})
	}
	
	method repartirBotin(botin) {
		vikingos.forEach({vikingo => vikingo.ganarOro(botin/self.cantInvasores())})
	}
	
	method aumentarVidasCobradasEn(cantidadDerrotados) {
		vikingos.take(cantidadDerrotados).forEach({vikingo => vikingo.cobrarVida()})
	}
}

// ------------------------------ vikingos

class Vikingo {
	var property casta = jarl
	var property monedas = 0
	
	method esProductivo()
	method tieneArmas() = true
	
	method puedeSubirAExpedicion(expedicion)
		= self.esProductivo() && casta.puedeSubirAExpedicion(self,expedicion)
	
	method ascender() {
		casta.efectoAscenso(self)
	}
	
	method ganarOro(cantMonedas) {
		monedas += cantMonedas
	}
}

class Soldado inherits Vikingo {
	var property cantVidasCobradas
	var property armas
	
	override method esProductivo() = cantVidasCobradas > 20 && self.tieneArmas()

	method efectoAscenso() {
		armas += 10
	}
	
	method cobrarVida() {
		cantVidasCobradas ++
	}
}

class Granjero inherits Vikingo {
	var cantHijos
	var cantHectareas
	
	override method esProductivo() = cantHectareas * 2 >= cantHijos
	
	method efectoAscenso() {
		cantHijos += 2
		cantHectareas += 2
	}	
}

object noPuedeSubirAExpedicion inherits Exception {}

// ------------------------------ castas sociales

class Casta {
	method puedeSubirAExpedicion(vikingo,expedicion) = true
}

object jarl {
	method puedeSubirAExpedicion(vikingo,expedicion) = not vikingo.tieneArmas()
	
	method ascender(vikingo) {
		vikingo.casta(karl)
		vikingo.efectoAscenso(10)
	}
}

object karl {
	method ascender(vikingo) {
		vikingo.casta(thrall)
	}
}

object thrall {}

// ------------------------------ objetivos

class Lugar {
	method serInvadidoPor(expedicion) {
		expedicion.repartirBotin(self.botin(expedicion.cantInvasores()))
		self.serDestruido(expedicion.cantInvasores())
	}
	
	method serDestruido(cantInvasores)
	method botin(cantInvasores)
}

class Capital inherits Lugar {
	var factorRiqueza
	var defensores
	
	override method botin(cantInvasores) = self.defensoresDerrotados(cantInvasores) * factorRiqueza
	method defensoresDerrotados(cantInvasores) = defensores.min(cantInvasores)

	method valeLaPena(cantInvasores) {
		return self.botin(cantInvasores)/3 >= cantInvasores
	}
	
	override method serInvadidoPor(expedicion) {
		super(expedicion)
		expedicion.aumentarVidasCobradasEn(self.defensoresDerrotados(expedicion.cantInvasores()))
	}
	
	override method serDestruido(cantInvasores) {
		defensores -= self.defensoresDerrotados(cantInvasores)
	}
	
}

class Aldea inherits Lugar {
	var cantCrucifijos
	
	override method botin(cantInvasores) = cantCrucifijos
	method valeLaPena(cantInvasores) = cantCrucifijos >= 15
	
	override method serInvadidoPor(cantInvasores) {
		super(cantInvasores)
		self.serDestruida(cantInvasores)
	}
	
	override method serDestruido(cantInvasores) {
		cantCrucifijos = 0
	}
}

class AldeaAmurallada inherits Aldea {
	var cantMinimaInvasores
	
	override method valeLaPena(cantInvasores)
		= super(cantInvasores) && cantInvasores > cantMinimaInvasores
}