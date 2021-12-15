/** First Wollok example */

object chasqui {
	method puedeEnviar(mensaje){
		return mensaje.size() < 50
	}
	method costoDe(mensaje){
		return 2* mensaje.size()
	}
}

object sherpa {
	var property costo = 60
	
	method puedeEnviar(mensaje){ 
		return mensaje.size() % 2 == 0
	}
	
	method costoDe(mensaje){ 
		return costo
		}
	}

object messich {
	var property costoPorPalabra = 10
	
	method puedeEnviar(mensaje) {
		return (not mensaje.startsWith("a")) //verifica si la primera letra del mensaje es "a"
	}
	
	method costoDe(mensaje) = costoPorPalabra * mensaje.words().size()
}


object pali {
	method puedeEnviar(mensaje) {
		return (self.esPalindromo(mensaje))
	}
	
	method esPalindromo(mensaje){
		return mensaje.replace(" ","").equalsIgnoreCase(mensaje.replace(" ","").reverse())
	}
	
	method costoDe(mensaje){
		return 80.min(4*mensaje.size())
	}
}

object agenciaDeMensajeria{
	var property mensajeros = [messich,pali,sherpa,chasqui]
	
	method quienEnvia(mensaje){
		return self.puedenEnviar(mensaje).min({mensajero => mensajero.costoDe(mensaje)})
	}
	
	method puedenEnviar(mensaje) = mensajeros.filter({mensajero => mensajero.puedeEnviar(mensaje)})
	
}
