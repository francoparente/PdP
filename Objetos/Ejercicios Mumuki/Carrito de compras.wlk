object carrito {
  var carrito = []
  
  method agregar(producto){
    carrito.add(producto)
  }
  method estaVacio(){
    return carrito.size() == 0
  }
  method cantidadDeProductos(){
    return carrito.size()
  }
  method totalAAbonar(){
    return carrito.sum({producto => producto.precioAAbonar()})
  }
}

class Producto {
  var descripcion
  var property precioUnitario
  method precioAAbonar(){
    return precioUnitario
  }
}
class ProductoPorPeso inherits Producto {
  var property precioPorKilo
  var property peso
  override method precioAAbonar(){
    return precioPorKilo * peso
  }
}