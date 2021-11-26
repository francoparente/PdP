class Linea {
	var property telefono
	const property packs = []
	
	method agregarPack(pack) {
		packs.add(pack)
	}
	
	method puedeRealizarConsumo(consumo) = packs.any({pack => pack.puedeSatisfacerConsumo(consumo)})
		
	method realizarConsumo(consumo) {
		packs.forEach({pack => pack.RealizarConsumo(consumo)})
	}
	
	method costoConsumo(consumo) {
		
	}
	
	method costoPromedioConsumos(fechaInicio,fechaFin) {
		
	}
	
	method costoTotalultimos30Dias(fechaActual) {
		
	}
}

//-------------------------------------- Packs

class Pack {
	method estaVencido() = false
	method costoConsumo(consumo)
	method puedeSatisfacerConsumo(consumo)
}

object credito {
	//var property fechaVencimiento
	//method estaVencido() = new Date() == fechaVencimiento
	
	method RealizarConsumo(consumo) {
		
	}
}

object megas {
	method RealizarConsumo(consumo) {
		
	}
	method costoConsumo(consumo) {
		
	}
}

object llamadasGratis {
	method RealizarConsumo(consumo) {
		
	}
}

object internetIlimitadoLosFindes {
	method RealizarConsumo(consumo) {
		
	}
}