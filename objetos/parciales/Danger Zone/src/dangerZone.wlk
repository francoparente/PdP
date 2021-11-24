//----------------------------------------------------------Mision
class Mision {
	const property habilidadesRequeridas = #{}
	var property peligrosidad
}
//----------------------------------------------------------Empleado
class Empleado {
	var property salud
	const property habilidades = #{}
	var property puesto
	
	method estaIncapacitado() = salud < puesto.saludCritica()
	
	method puedeUsarHabilidad(habilidad) = self.tieneHabilidad(habilidad) && !self.estaIncapacitado()
	
	method tieneHabilidad(habilidad) = habilidades.contains(habilidad)
	
	method cumplirMision(mision) {
		if(self.puedeCumplirMision(mision))
			salud -= mision.peligrosidad()
	}
	
	method puedeCumplirMision(mision) {
		return 	mision.habilidadesRequeridas().foreach({habilidad => self.tieneHabilidad(habilidad)})
				&& !self.estaIncapacitado()
	}
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

