//--------------------- Espacio Urbano

class EspacioUrbano {
	var property valuacion = 0
	var property superficie = 0
	var property nombre = ""
	var property vallado
	
	method tieneVallado() {
		return vallado
	}
	method esGrande(superficie) {
		return superficie > 50 && cumpleCondiciones()
	}
}
//--------------------- Instancias - Espacio Urbano

class Plaza inherits EspacioUrbano {
	var property cantCanchas = 0
	var espacioEsparcimiento
	
	method cumpleCondiciones() {
		return cantCanchas > 2
	}
}

class Plazoleta inherits EspacioUrbano {
	var procer = ""
	
	method cumpleCondiciones() {
		return procer == "San Martín" && tieneVallado()
	}
}

class Anfiteatro inherits EspacioUrbano {
	var capacidad = 1000
	var tamanioEscenario = 0
	
	method cumpleCondiciones() {
		return capacidad > 500
	}
}

class Multiespacio inherits EspacioUrbano {
	var espaciosUrbanos = []
	
	method cumpleCondiciones() {
		
	}
}

//--------------------- Persona

class Persona {
	var property profesion = ""
}

object cerrajero inherits Persona {
	method puedeTrabajar(espacio) {
		return espacio.tieneVallado()
	}
	method trabajar(espacio) {
		
	}
}

object jardinero inherits Persona {
	method puedeTrabajar(espacio) {
		
	}
}








