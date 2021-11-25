import wollok.game.*

// -------------------------------------------- Persona

class Persona {
	var property posicion
	var property criterio
	const property elementosCercanos = []
	
	method tieneElementoCerca(elemento) = elementosCercanos.contains(elemento)
	
	method pasarElemento(elemento,personaQuePide) {
		if(!personaQuePide.tieneElementoCerca(elemento))
			throw new DomainException(message = "La persona a la que se le pidió el elemento '" + elemento + "', no lo tiene cerca.")
		criterio.pasarElemento(elemento,self,personaQuePide)
	}
	
	method primerElemento() = elementosCercanos.first()
	
	method agregarElementos(elementos) {
		elementosCercanos.addAll(elementos)
	}
	method quitarElementos(elementos) {
		elementosCercanos.removeAllSuchThat({elemento => elementos.contains(elemento)})
	}
}

// -------------------------------------------- Criterio

class CriterioPasarElementos {
	
	method elementosAPasar(elemento,personaQueDa)
	
	method pasarElemento(elemento,personaQueDa,personaQuePide) {
		const elementosAPasar = personaQueDa.elementosAPasar(personaQueDa)
		personaQuePide.agregarElementos(elementosAPasar)
		personaQueDa.quitarElementos(elementosAPasar)
	}
}

// -------------------------------------------- Instancias de Criterio

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
