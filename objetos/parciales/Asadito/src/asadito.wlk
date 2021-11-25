class Persona {
//	var property posicion
//	var property criterio
	const property elementosCercanos = #{}
	
	method tieneElementoCerca(elemento) = elementosCercanos.contains(elemento)
	
	method pedirElemento(elemento, personaQueDa) {
		if(!personaQueDa.tieneElementoCerca(elemento))
			throw new DomainException(message = "La persona a la que se le pidió el elemento '" + elemento + "', no lo tiene cerca.")
		personaQueDa.pasarElemento(elemento, self)
	}
	
}
/*
object sordo {
	method pasarElemento(elemento, persona) {
		elementosCercanos
	}
}

object grunion {
	
}

object charlatan {
	
}

object bueno {
	
}
*/