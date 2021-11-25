import wollok.game.*

// -------------------------------------------- Persona

class Persona {
	var property posicion = 0
	var property criterioPasarElementos = sordo
	var property criterioElegirComida = vegetariano
	const property elementosCercanos = []
	const property comidasIngeridas = []
	
	method tieneElementoCerca(elemento) = elementosCercanos.contains(elemento)
	
	method pasarElemento(elemento,personaQuePide) {
		if(!personaQuePide.tieneElementoCerca(elemento))
			throw new DomainException(message = "La persona a la que se le pidió el elemento '" + elemento + "', no lo tiene cerca.")
		criterioPasarElementos.pasarElemento(elemento,self,personaQuePide)
	}
	
	method primerElemento() = elementosCercanos.first()
	
	method agregarElementos(elementos) {
		elementosCercanos.addAll(elementos)
	}
	method quitarElementos(elementos) {
		elementosCercanos.removeAllSuchThat({elemento => elementos.contains(elemento)})
	}
	method estaPipon() = comidasIngeridas.any({comida => comida.esPesada()})
	
	method comer(comida) {
		if(not criterioElegirComida.acepta(comida))
			throw new DomainException (message = "La persona no aceptó la comida")
		return comidasIngeridas.add(comida)
	}
}

// -------------------------------------------- Comida

class Comida {
	var property calorias
	var property esCarne = false
	
	method esPesada() = calorias > 500
}

// -------------------------------------------- Criterio para pasar elementos

class CriterioPasarElementos {
	
	method elementosAPasar(elemento,personaQueDa)
	
	method pasarElemento(elemento,personaQueDa,personaQuePide) {
		const elementosAPasar = personaQueDa.elementosAPasar(personaQueDa)
		personaQuePide.agregarElementos(elementosAPasar)
		personaQueDa.quitarElementos(elementosAPasar)
	}
}

// -------------------------------------------- Instancias de Criterio para pasar elementos

object sordo inherits CriterioPasarElementos {
	override method elementosAPasar(elemento,personaQueDa) = [personaQueDa.primerElemento()]
}

object grunion inherits CriterioPasarElementos {
	override method elementosAPasar(elemento,personaQueDa) = personaQueDa.elementosCercanos()
}

object charlatan {
	method pasarElemento(elemento,personaQueDa,personaQuePide){
		const posicionPersonaQuePide = personaQuePide.posicion()
		personaQuePide.posicion(personaQueDa.posicion())
		personaQueDa.posicion(posicionPersonaQuePide)
	}
}

object bueno inherits CriterioPasarElementos {
	override method elementosAPasar(elemento,personaQueDa) = [elemento]
}

// -------------------------------------------- Instancias de Criterio para elegir comida

object vegetariano {
	method acepta(comida) = not comida.esCarne()
}

object dietetico {
	var property limiteCalorias = 500
	method acepta(comida) = comida.calorias() < limiteCalorias
}

class Alternado {
	var quiero = true
	method acepta(comida) {
		quiero = not quiero
		return quiero
	} 
}

class Combinacion {
	const property criteriosDeAceptacion = []
	
	method agregarCriterios(criterios) = criteriosDeAceptacion.addAll(criterios)
	method acepta(comida) = criteriosDeAceptacion.all({criterio => criterio.acepta(comida)})
}









