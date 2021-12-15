// --------------------- Mensajeros
class MensajerxEstandar {

	var property mensajesEnviados = []
	var property sector = new Sector()

	var property tipoMensajero = paranoico // asumimos q por default todos son paranoicos

	method enviar(mensaje) {
		mensajesEnviados.add(tipoMensajero.definirMensaje(mensaje))
	}

	method puedeEnviar(mensaje) {
		return mensaje.size() >= 20
	}

	method costoDe(mensaje) {
		return (self.cantPalabrasMensaje(mensaje) * (self.sector().costoDe()))
	}

	method cantidadMensajesMes(historial) = historial.count({ elementoHistorial => elementoHistorial.mensajeroAsignado() == self })
	
	method cantPalabrasMensaje(mensaje) {
		return mensaje.words().size()
	}
}

// --------------------- Instancias de Mensajeros
object chasqui inherits MensajerxEstandar {

	override method puedeEnviar(mensaje) {
		return (mensaje.size() < 50) && super(mensaje)
	} // puede enviar mensajes que tengan menos de 50 caracteres.

	override method costoDe(mensaje) {
		return 2 * mensaje.size()
	} // el costo de cada mensaje es el tamaño del mensaje multiplicado por 2.

}

object sherpa inherits MensajerxEstandar {

	var property costo = 60

	override method puedeEnviar(mensaje) {
		return (mensaje.size().even()) && super(mensaje)
	}

	override method costoDe(mensaje) {
		return costo
	}

}

object messich inherits MensajerxEstandar {

	var property costoPorPalabra = 10

	override method puedeEnviar(mensaje) {
		return (not mensaje.startsWith("a")) && super(mensaje) // verifica si la primera letra del mensaje es "a"
	}

	override method costoDe(mensaje) = costoPorPalabra * self.cantPalabrasMensaje(mensaje)
}

object pali inherits MensajerxEstandar {

	override method puedeEnviar(mensaje) {
		return (self.esPalindromo(mensaje)) && super(mensaje)
	} // puede enviar mensajes solo si son palíndromos.

	method esPalindromo(mensaje) {
		return mensaje.replace(" ", "").equalsIgnoreCase(mensaje.replace(" ", "").reverse())
	} // devuelve si es o no palíndromo.

	override method costoDe(mensaje) {
		return 80.min(4 * mensaje.size())
	} // el costo de cada mensaje es el tamaño del mensaje multiplicado por 4 y puede ser 80 como máximo.

}

object pichca inherits MensajerxEstandar {

	override method puedeEnviar(mensaje) {
		return self.cantPalabrasMensaje(mensaje) > 3
	} // puede enviar mensajes que tengan más de 3 palabras.

	override method costoDe(mensaje) {
		return mensaje.size() * random.randomizar(3, 7)
	} // el costo de cada mensaje es el tamaño del mensaje multiplicado por un valor random entre 3 y 7.
}

object random {

	method randomizar(num1, num2) {
		return new Range(start = num1, end = num2).anyOne()
	}

} // objeto que devuelve un valor random.

// --------------------- Sectores
class Sector {

	var property costoDe = 0

}


// --------------------- Mensajes

class Mensaje {

	var property mensaje
	var property costoDelMensaje = 10 //dejo este valor por default, pero creo que se deberia instanciar al crear un mensaje. 

	method costoDe() = costoDelMensaje + agenciaDeMensajeria.costoDe(mensaje) //sumo el costo del mensaje con el costo que dice el que debe enviarlo
	
	
	method gananciaMensaje() {
		if (mensaje.size() < 30) {
			return 500
		} else {
			return 900
		}
	}

}

// --------------------- Instancias de Mensajes
class MensajeCantado inherits Mensaje {

	var property duracion = 0

	override method costoDe() {
		return super() * 0.1
	}

}

class MensajeElocuente inherits Mensaje {

	method palabrasConUnaODosLetras() {
		return mensaje.words().filter({ unMensaje => (unMensaje.size() == 2) || (unMensaje.size() == 1) })
	}

	method gradoElocuencia() {
		return self.palabrasConUnaODosLetras().size() + 1
	}

	method ganancia() {
		return self.gradoElocuencia() * self.gananciaMensaje() 
	}
	
	method entregar() = mensaje

}

class MensajeCifrado inherits Mensaje {

	method entregar() = mensaje.reverse()
	
	override method costoDe() = super() + (0).max(3 * mensaje.indexOf("a"))
}

// --------------------- Agencia de Mensajería
object agenciaDeMensajeria {

	var property mensajeros = [ messich, pali, sherpa, chasqui ]
	const property historial = []
	// [("hola",chasqui),("chau",sherpa),("que tal",sherpa)]

	method quienEnvia(mensaje) {
		return self.puedenEnviar(mensaje).min({ mensajero => mensajero.costoDe(mensaje) })
	}

	method puedenEnviar(mensaje) = mensajeros.filter({ mensajero => mensajero.puedeEnviar(mensaje) })
	
	method validarMensaje(mensaje){
		if (mensaje.isEmpty()) {
			throw new DomainException(message = "La operacion no se puede realizar: mensaje vacio")
		}
		if (self.puedenEnviar(mensaje).isEmpty()) {
			throw new DomainException(message = "La operacion no se puede realizar: nadie puede enviarlo")
		}
	
	}
	
	method enviarMensaje(mensaje) {
		self.validarMensaje(mensaje)
		historial.add(new ElementoHistorial(mensajeEnviado = new Mensaje(mensaje = mensaje), mensajeroAsignado = self.quienEnvia(mensaje))) // Se agrega registro al historial. La fecha la setea la clase.
		self.quienEnvia(mensaje).enviar(mensaje) // Se envía el mensaje.
	}

	method historialUltimoMes() = historial.filter({ elemento => elemento.esDelUltimoMes() })

	method gananciaNeta() = self.historialUltimoMes().sum({ elementoHistorial => elementoHistorial.calcularGanancia() })

	method chasquiQuilla() = self.historialUltimoMes().max({ elementoHistorial => elementoHistorial.mensajeroAsignado().cantidadMensajesMes(self.historialUltimoMes()) }).mensajeroAsignado()

	method costoDe(mensaje) = self.quienEnvia(mensaje).costoDe(mensaje)
}

class ElementoHistorial {

	var property mensajeEnviado
	var property mensajeroAsignado
	var property fecha = new Date()

	method calcularGanancia() = mensajeEnviado.gananciaMensaje() - mensajeroAsignado.costoDe(mensajeEnviado.mensaje())
	
	method esDelUltimoMes(){
		const hoy = new Date()
		return fecha.year() == hoy.year() && fecha.month() == hoy.month()
	}

}

//------------------------------------------------------------------- ↓	REVISAR CON BRIAN ↓
//TIPOS DEL PUNTO 10
object paranoico {

	method definirMensaje(unMensaje) = new MensajeCifrado(mensaje = unMensaje)

}

class Alegre {

	var property gradoAlegria

	method definirMensaje(unMensaje) {
		if (gradoAlegria > 10) {
			return new MensajeCantado(mensaje = unMensaje, duracion = self.duracion())
		} else {
			return new Mensaje(mensaje = unMensaje)
		}
	}

	method duracion() {
		if (gradoAlegria.even()) {
			return 6 * gradoAlegria
		} else {
			return 500
		}
	}

}

class Serio {

	var property mensajesEnviados = [] 

	method definirMensaje(unMensaje) {
		mensajesEnviados.add(unMensaje)
		if (mensajesEnviados.take(3).contains(unMensaje)) {
			return new MensajeElocuente(mensaje = unMensaje)
		}
		return new MensajeCifrado(mensaje = unMensaje)
	}

}
