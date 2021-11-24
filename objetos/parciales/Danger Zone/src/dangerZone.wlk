//----------------------------------------------------------Mision
class Mision {
	const property habilidadesRequeridas = #{}
	var property peligrosidad
	
	method esCumplidaPor(asignado) {
		self.validarHabilidades(asignado)
		asignado.recibirDanio(peligrosidad)
		asignado.completarMision(self)
	}
	
	method validarHabilidades(asignado) {
		if (!self.reuneHabilidadesRequeridas(asignado))
			self.error("El asignado no puede usar las habilidades requeridas")
	}
	
	method enseniarHabilidades(empleado) {
		self.habilidadesQueNoPosee(empleado).forEach({hab=>empleado.aprenderHabilidad(hab)})
	}
	
	method reuneHabilidadesRequeridas(asignado)
		= habilidadesRequeridas.all({habilidad => asignado.puedeUsarHabilidad(habilidad)})
	
	method habilidadesQueNoPosee(empleado) = habilidadesRequeridas.filter({hab => ! empleado.tieneHabilidad(hab)})
}
//----------------------------------------------------------Empleado
class Empleado {
	var property salud
	const property habilidades = #{}
	var property puesto
	
	method estaIncapacitado() = salud < puesto.saludCritica()
	method puedeUsarHabilidad(habilidad) = self.tieneHabilidad(habilidad) && !self.estaIncapacitado()
	method tieneHabilidad(habilidad) = habilidades.contains(habilidad)
	method recibirDanio(peligrosidad) { salud -= peligrosidad}
	method estaVivo() = salud > 0
	
	method finalizarMision(mision){
		if(self.estaVivo())
			self.completarMision(mision)
	}
	method completarMision(mision) {
		puesto.completarMision(mision,self)
	}
	method aprenderHabilidad(habilidad) {
		habilidades.add(habilidad)
	}
}
//----------------------------------------------------------Jefe
class Jefe inherits Empleado {
	const empleados = #{}
	
	override method tieneHabilidad(habilidad)
		= super(habilidad) || self.algunEmpleadoPuedeUsarHabilidad(habilidad)
	
	method algunEmpleadoPuedeUsarHabilidad(habilidad)
		= empleados.any({empleado => empleado.puedeUsarHabilidad(habilidad)})
}
//----------------------------------------------------------Puestos
object espia {
		
	method saludCritica() = 15
	
	method completarMision(mision,empleado) {
		mision.enseniarHabilidades(empleado)
	}
}

class Oficinista {
	var property estrellas
	
	method saludCritica() = 40-5* estrellas
	
	method ganarEstrella() {
		estrellas++
	}
	
	method puedeSerEspia() {
		return estrellas >= 3
	}
	
	method completarMision(mision,empleado) {
		self.ganarEstrella()
		empleado.puesto(espia)
	}
}
//----------------------------------------------------------Equipo
class Equipo inherits Empleado{
	const empleados = #{}
	
	override method finalizarMision(mision){
		empleados.forEach({empleado => empleado.finalizarMision(mision)})
	}
	
	override method recibirDanio(peligrosidad) {
		empleados.forEach({empleado => empleado.recibirDanio(peligrosidad/3)})
	}
	
	override method puedeUsarHabilidad(habilidad)
		= self.algunEmpleadoPuedeUsarHabilidad(habilidad)
	
	method algunEmpleadoPuedeUsarHabilidad(habilidad)
		= empleados.any({empleado => empleado.puedeUsarHabilidad(habilidad)})
}

