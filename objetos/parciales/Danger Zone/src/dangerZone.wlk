//----------------------------------------------------------Mision
class Mision {
	const property habilidadesRequeridas = #{}
	var property peligrosidad
	
	method esCumplidaPor(asignado) {
		if (!self.habilidadesRequeridas().all({habilidad => asignado.puedeUsarHabilidad(habilidad)}))
			self.error("El asignado no puede usar las habilidades requeridas")
		asignado.salud(asignado.salud()-peligrosidad)
	}
}
//----------------------------------------------------------Empleado
class Empleado {
	var property salud
	const property habilidades = #{}
	var property puesto
	
	method estaIncapacitado() = salud < puesto.saludCritica()
	method puedeUsarHabilidad(habilidad) = self.tieneHabilidad(habilidad) && !self.estaIncapacitado()
	method tieneHabilidad(habilidad) = habilidades.contains(habilidad)
	/*
	method cumplirMision(mision) {
		if(self.puedeUsarHabRequeridas(mision))
			salud -= mision.peligrosidad()
	}
	
	method puedeUsarHabRequeridas(mision) {
		return 	mision.habilidadesRequeridas().all({habilidad => self.puedeUsarHabilidad(habilidad)})
	}
	*/
}
//----------------------------------------------------------Jefe
class Jefe inherits Empleado {
	const empleados = #{}
	
	override method tieneHabilidad(habilidad)
		= super(habilidad) || self.algunEmpleadoTieneHabilidad(habilidad)
	
	method algunEmpleadoTieneHabilidad(habilidad)
		= empleados.any({empleado => empleado.puedeUsarHabilidad(habilidad)})
}
//----------------------------------------------------------Puestos
class Espia inherits Empleado {
		
	method saludCritica() = 15
	
	method aprenderHabilidad(habilidad,mision) {
		if(mision.habilidadesRequeridas().foreach({unaHabilidad => self.habilidades().contains(unaHabilidad)}))
			return self.habilidades().add(habilidad)
		return 0
	}
}

class Oficinista inherits Empleado {
	var property estrellas
	
	method saludCritica() = 40-5* estrellas
	
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
//----------------------------------------------------------Equipo
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

