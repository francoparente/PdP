class Mision {
	const property habilidadesRequeridas = #{}
	var property peligrosidad
}

class Empleado {
	var property salud
	const property habilidades = #{}
	
	method saludCritica()
	
	method estaIncapacitado() = salud < self.saludCritica()
	
	method puedeUsarHabilidad(habilidad) {
		return self.tieneHabilidad(habilidad) && !self.estaIncapacitado()
	}
	
	method tieneHabilidad(habilidad) {
		return habilidades.contains(habilidad)
	}
	
	method cumplirMision(mision) {
		if(self.puedeCumplirMision(mision))
			salud -= mision.peligrosidad()
	}
	
	method puedeCumplirMision(mision) {
		return 	mision.habilidadesRequeridas().foreach({habilidad => self.tieneHabilidad(habilidad)})
				&& !self.estaIncapacitado()
	}
}

class Espia inherits Empleado {
		
	override method saludCritica() = 15
	
	method aprenderHabilidad(habilidad,mision) {
		if(mision.habilidadesRequeridas().foreach({unaHabilidad => self.habilidades().contains(unaHabilidad)}))
			return self.habilidades().add(habilidad)
		return 0
	}
}

class Oficinista inherits Empleado {
	var property estrellas
	
	override method saludCritica() = 40-5* estrellas
	
	method ganarEstrella() {
		estrellas++
	}
	
	override method cumplirMision(mision) {
		self.ganarEstrella()
	}
	
	method puedeSerEspia() {
		return estrellas >= 3
	}
}

class Jefe inherits Empleado {
	const empleados = #{}
	
	override method tieneHabilidad(habilidad) {
		return super(habilidad) && empleados.foreach({empleado => empleado.habilidades().contains(habilidad)})
	}
}

class Equipo inherits Empleado{
	const empleados = #{}
	
	override method cumplirMision(mision) {
		if(self.puedeCumplirMision(mision))
			empleados.foreach({empleado => empleado.salud(salud-mision.peligrosidad()/3)})
	}
	
	override method puedeCumplirMision(mision) {
		return empleados.any({empleado => empleado.puedeCumplirMision(mision)})
	}
}

