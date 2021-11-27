// ------------------------------------------------ PARCIAL OBJETOS
// FRANCO PARENTE
// 26/11/2021
// PdeP viernes noche - K2053

// ------------------------------------------------ Agencia

class Agencia {
	
	method contratar(cliente,servicio) {	
		cliente.contratar(servicio)			// El servicio puede ser tanto un contratista como un combo de contratistas ya que comparten la misma interfaz (polimorfismo)
	}
	
	method clientesConLosQueSeTrabajo(contratista) {
		contratista.clientesConocidos()
	}
	
	method cuantoLlevaGastadoUnCliente(cliente) {
		cliente.dineroGastado()
	}
}

// ------------------------------------------------ Cliente

class Cliente {
	var property ahorros
	var property presupuesto = ahorros * 0.2
	var property dineroGastado = 0
	var property casa
	var property criterioContratacion		// Tanto en casa como en criterioContratacion se hace uso de composición. El cliente podría cambiar de casa o criterio dinámicamente.
	
	method puedeContratar(servicio) {
		criterioContratacion.aceptarCosto(servicio)
	}
	method contratar(servicio) {
		if(not self.puedeContratar(servicio))
			throw new DomainException (message = "El cliente no tiene suficiente presupuesto para contratar el servicio.")
		self.disminuirAhorrosLuegoDeContratar(servicio)
		self.sumarDineroGastadoLuegoDeContratar(servicio)
		self.agregarseALosClientesDelContratista(servicio)
	}
	
	method disminuirAhorrosLuegoDeContratar(servicio) {
		ahorros -= servicio.costoServicioPara(self)
	}
	
	method sumarDineroGastadoLuegoDeContratar(servicio) {
		dineroGastado += servicio.costoServicioPara(self)
	}
	
	method agregarseALosClientesDelContratista(servicio) {
		servicio.agregarClienteAConocidos(self)
	}
	
	method pisos() = casa.pisos()
	method ambientes() = casa.ambientes()
	method metrosCuadrados() = casa.metrosCuadrados()
	method tieneCasaComplicada() = casa.esComplicada()
	method tieneCasaConMasDeTresAmbientes() = casa.tieneMasDeTresAmbientes()
}

// ------------------------------------------------ Contratista

class Contratista {
	const property clientesConocidos = #{}
	
	method costoServicioPara(cliente)
	method agregarClienteAConocidos(cliente) {
		clientesConocidos.add(cliente)
	}
}

// ------------------------------------------------ Instancias de Contratista

class Arquitecto inherits Contratista {
	
	override method costoServicioPara(cliente) = 100000 * cliente.pisos()
}

class MaestroMayor inherits Contratista {
	
	override method costoServicioPara(cliente) {
		if(cliente.tieneCasaComplicada())
			return 50000 * cliente.ambientes() + 0.2 * 50000 * cliente.ambientes()
		return 50000 * cliente.ambientes()
	}
}

class Electricista inherits Contratista {
	
	override method costoServicioPara(cliente) {
		if(cliente.tieneCasaComplicada())
			return 200 * cliente.ambientes()
		return 100 * cliente.ambientes()
	}
}

class Plomero inherits Contratista {
	override method costoServicioPara(cliente) {
		if(cliente.tieneCasaConMasDeTresAmbientes())
			return 100 * cliente.ambientes() + 100 * cliente.ambientes() * 0.1
		return 100 * cliente.ambientes()
	}
}

class Pintor inherits Contratista {
	var property costoPintura
	
	override method costoServicioPara(cliente) =  70 * cliente.metrosCuadrados() + costoPintura
}

class Albanil inherits Contratista {
	var property horasPorAmbiente
	
	override method costoServicioPara(cliente) =  100 * horasPorAmbiente * cliente.ambientes()
}

class Combo inherits Contratista {
	const property contratistas
	
	override method costoServicioPara(cliente) = contratistas.sum({contratista => contratista.costoServicioPara(cliente)})
	
	override method agregarClienteAConocidos(cliente) {
		contratistas.forEach({contratista => contratista.agregarClienteAConocidos(cliente)})
	}
}

// ------------------------------------------------ Criterios de Contratacion

class Precavido {
	var property porcentaje // debería ser entre 0 y 1, para poder multiplicarlo por el presupuesto del cliente.
	
	method aceptarCosto(cliente,servicio) = servicio.costoServicioPara(self) < porcentaje * cliente.presupuesto()
}

object derrochon {
	method aceptarCosto(cliente,servicio) = servicio.costoServicioPara(self) > cliente.presupuesto()
}

object complicado {
	method aceptarCosto(cliente,servicio) = servicio.costoServicioPara(self) % 7 == 0
}

object criterioActual {
	method aceptarCosto(cliente,servicio) = servicio.costoServicioPara(self) < cliente.presupuesto()
}

// ------------------------------------------------ Casa

class Casa {
	var property ambientes
	var property metrosCuadrados
	var property pisos
	
	method esComplicada() = pisos > 2
	method tieneMasDeTresAmbientes() = ambientes > 3
}




