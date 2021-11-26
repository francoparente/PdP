class Linea {
	var property telefono
	const property packs = []
	
	method realizarConsumo() {
		packs.forEach({pack => pack.RealizarConsumo()})
	}
	
	method agregarPack(pack) {
		packs.add(pack)
	}
}

//-------------------------------------- Packs

class Pack {
	method estaVencido() = false
}

object credito {
	var property fechaVencimiento
	
	method estaVencido() = new Date() == fechaVencimiento
	method RealizarConsumo() {
		
	}
}

object megas {
	method RealizarConsumo() {
		
	}
}

object llamadasGratis {
	method RealizarConsumo() {
		
	}
}

object internetIlimitadoLosFindes {
	method RealizarConsumo() {
		
	}
}