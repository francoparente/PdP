//------------------------------- Aseguradora

class Aseguradora {
	
	method montoAPagar(siniestro,vehiculo) {
		if(self.validarVehiculo(siniestro,vehiculo))
			return vehiculo.cuantoCubreSeguro(siniestro)
	}
	
	method validarVehiculo(siniestro,vehiculo) {
		if(!siniestro.participo(vehiculo))
			throw new NoParticipoVehiculo(message = "Vehiculo no participó en siniestro")
		return true
	}
}

class NoParticipoVehiculo inherits DomainException {}

//------------------------------- Siniestro

class Vehiculo {
	var property seguro
	
	const siniestros_hist() = #{}
	
	method cuantoCubreSeguro(siniestro) {
		return seguro.cuantoCubrePor(siniestro,self)
	}
	method noCubierto(siniestro) = siniestros.sum({siniestro => poliza.noCubierto(siniestro,self)})
}

//------------------------------- Seguros

class Seguro {
	var property aseguradora
	
	method cuantoCubrePor(siniestro,vehiculo) {
		return self.danios(siniestro,vehiculo).sum({danio => danio.monto()})
	}
	
	method danios(siniestro,vehiculo)
}

class ContraTerceros inherits Seguro {
	
	override method danios(siniestro,vehiculo) {
		return siniestro.danios().filter({danio => danio.afectado() != vehiculo})
	}
	
	method noCubierto(siniestro,vehiculo) = siniestro.danios().filter({danio => danio.afectado() == vehiculo})
}

class ContraTodoRiesgo inherits Seguro {
	override method danios(siniestro,_) = siniestro.danios()
	
	method noCubierto(siniestro,vehiculo) = 0
}

//------------------------------- Siniestro

class Siniestro {
	const property danios = #{}
	
	method calcularDaniosPara(vehiculo) = self.danioVehiculo(vehiculo).monto()
	
	method danioVehiculo(vehiculo) = danios.find({danio => danio.involucrado() == vehiculo})
}

//------------------------------- Daño

class Danio {
	var property monto
	var property afectado
}

interface Involucrado {}
