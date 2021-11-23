//------------------------------------------ Espacio Urbano

class EspacioUrbano {
	var property valuacion = 0
	var property superficie = 0
	var property nombre = ""
	var property tieneVallado
	const property trabajosRealizados = #{}
	
	method esGrande() {
		return superficie > 50 && self.cumpleCondiciones()
	}
	method cumpleCondiciones()
	
	method esVerde() = false
	method esLimpiable() = false
	method aumentarValuacion(aumento){
		valuacion += aumento
	}
}
//------------------------------------------ Instancias - Espacio Urbano

class Plaza inherits EspacioUrbano {
	var property cantCanchas
	var property espacioEsparcimiento
	
	override method cumpleCondiciones() = return cantCanchas > 2
	override method esVerde() = cantCanchas == 0
	override method esLimpiable() = true
}

class Plazoleta inherits EspacioUrbano {
	var property procer
	
	override method cumpleCondiciones() = procer == "San Martín" && tieneVallado
}

class Anfiteatro inherits EspacioUrbano {
	var property capacidad
	var property tamanioEscenario
	
	override method cumpleCondiciones() = capacidad > 500
	override method esLimpiable() = self.esGrande()
}

class Multiespacio inherits EspacioUrbano {
	const property espaciosUrbanos
	
	override method cumpleCondiciones() = espaciosUrbanos.all({espacio => espacio.esGrande()})
	override method esVerde() = self.espaciosUrbanos().size() > 3
}

//------------------------------------------ Trabajador y Profesión

class Trabajador {
	var property profesion
	var property valorHora = 100
	
	method trabajaEn(espacio) {
		profesion.trabajaEn(espacio,self)
	}
}

class Profesion {
	method trabajarEn(espacio,trabajador) {
		self.validarTrabajo(espacio)
		self.producirEfecto(espacio)
		self.registrarTrabajo(espacio,trabajador)
	}
	method validarTrabajo(espacio) {
		if(!self.puedeTrabajarEn(espacio)){
			throw new DomainException(message = "El trabajador no puede realizar el trabajo en este espacio.")
			}
	}
	method puedeTrabajarEn(espacio)
	method producirEfecto(espacio)
	method registrarTrabajo(espacio,trabajador)
}

//------------------------------------------ Instancias de Profesión

object cerrajero inherits Profesion {
	override method puedeTrabajarEn(espacio) = !espacio.tieneVallado()
	override method producirEfecto(espacio) {
		espacio.tieneVallado(true)
	}
	override method registrarTrabajo(espacio,trabajador) {
		
	} 
	
}

object jardinero inherits Profesion {
	override method puedeTrabajarEn(espacio) = espacio.esVerde()
	override method producirEfecto(espacio) {
		espacio.aumentarValuacion(espacio.valuacion() * 0.1)
	}
	override method registrarTrabajo(espacio,trabajador) {
		
	}
}

object encargado inherits Profesion {
	override method puedeTrabajarEn(espacio) = espacio.esLimpiable()
	override method producirEfecto(espacio) {
		espacio.aumentarValuacion(5000)
	}
	override method registrarTrabajo(espacio,trabajador) {
		
	}
}

//------------------------------------------ Trabajo

class Trabajo {
	
}




