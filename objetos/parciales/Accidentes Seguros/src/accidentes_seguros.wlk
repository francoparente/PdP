const CT = "contra terceros"
const TR = "contra todo riesgo"

class Vehiculo {
	var property seguro
	
	method montoAPagar(siniestro) {
		
	}
	method gastosArreglos_hist() {
		
	}
}

const fitito = new Vehiculo(seguro = CT)
const bondi = new Vehiculo(seguro = TR)
const moto = new Vehiculo(seguro = CT)

class Siniestro {
	var property danios = 0
	var property daniosAfectados =0
}

object  siniestro1 inherits Siniestro {
	
}

class Aseguradora {
	//var property seguros = [contraTerceros, todoRiesgo]
	
	method montoAPagar(siniestro,vehiculo) {
		
	}
}