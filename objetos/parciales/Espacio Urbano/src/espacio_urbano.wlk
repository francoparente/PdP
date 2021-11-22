//--------------------- Espacio Urbano

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
}
//--------------------- Instancias - Espacio Urbano

class Plaza inherits EspacioUrbano {
	var property cantCanchas
	var property espacioEsparcimiento
	
	override method cumpleCondiciones() = return cantCanchas > 2
}

class Plazoleta inherits EspacioUrbano {
	var property procer
	
	override method cumpleCondiciones() = procer == "San Martín" && tieneVallado
}

class Anfiteatro inherits EspacioUrbano {
	var property capacidad
	var property tamanioEscenario
	
	override method cumpleCondiciones() = capacidad > 500
}

class Multiespacio inherits EspacioUrbano {
	const property espaciosUrbanos
	
	override method cumpleCondiciones() = espaciosUrbanos.all({espacio => espacio.esGrande()})
}

//--------------------- Trabajador y Profesión

class Trabajador {
	var property profesion
	var property valorHora
}

class Profesion {
	method trabajarEn(espacio,trabajador) {
		
	}
}

//--------------------- Instancias de Profesión

object cerrajero inherits Profesion {
	
}

object jardinero inherits Profesion {
	
}

object encargado inherits Profesion {
	
}

//--------------------- Trabajo

class Trabajo {
	
}




