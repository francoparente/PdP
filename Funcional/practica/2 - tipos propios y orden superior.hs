-------------------Práctica Tipos Propios y Orden Superior-------------------

-- 1) Queremos calcular el sueldo de los empleados de nuestra empresa. Tenemos dos tipos de empleado:
-- ● Los comunes: nos interesa saber el sueldo básico y el nombre.
-- ● Los jerárquicos: nos interesa conocer el sueldo básico, la cantidad de gente a cargo y el nombre.
 
data Empleado = Comun {nombre :: String, sueldoBasico :: Integer}
              | Jerarquico {nombre :: String, sueldoBasico :: Integer, cantidadACargo :: Integer}
 
-- El sueldo que cobran los comunes se determina por el sueldo básico, en los empleados
-- jerárquicos se calcula como sueldo básico + plus por la cantidad de gente a cargo (500 por cada persona a cargo).


calcularSueldo :: Empleado -> Integer
calcuarSueldo (Comun _ sueldoBasico) = sueldoBasico
calcularSueldo (Jerarquico _ sueldoBasico cant) = sueldoBasico + plus cant

plus cant = cant * 500

persona1 = Comun "Franco" 30000
persona2 = Jerarquico "Cande" 30000 3

--      *Main> calcularSueldo franco
--      30000
--      *Main> calcularSueldo cande
--      31500

-- 2) Se conocen estas bebidas:

data Bebida = Cafe {nombreBebida :: String}
            | Gaseosa {sabor ::String , azucar :: Integer}

-- Dado un producto determinar si es energizante.
-- ●   Si es café es energizante si es un capuchino.
-- ●   Si es una gaseosa es energizante si es de sabor a pomelo y tiene más de 10gr de azúcar.

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe nombre) = nombre == "capuchino"
esEnergizante (Gaseosa sabor gramos) = sabor == "pomelo" && gramos > 10

bebida1 = Cafe "capuchino"
bebida2 = Cafe "macchiato"
bebida3 = Gaseosa "naranja" 18
bebida4 = Gaseosa "pomelo" 5
bebida5 = Gaseosa "pomelo" 12

--      *Main> esEnergizante bebida1
--      True


-- 3) Resolver la función find’ que encuentra el primer elemento que cumple una condición.
-- No se puede resolver con recursividad. Si ningún elemento cumple la condición dejar que falle.

find' :: (a -> Bool) -> [a] -> a
find' criterio lista =  head.filter criterio $ lista

--      *Main> find' even [1,5,6,7,9,23,10]
--      6

-- 3.1) Aprovechar la función find’ para aplicarla a este dominio.

data Politico = Politico {proyectosPresentados :: [String], sueldo :: Float, edad :: Int } deriving Show
 
politicos = [   
                Politico ["ser libres", "libre estacionamiento coches politicos", "ley no fumar", "ley 19182"] 20000 81,
                Politico ["tratar de reconquistar luchas sociales"] 10000 63,
                Politico ["tolerancia 100 para delitos"] 15500 49
            ]
 
-- Queremos encontrar:
-- a)  un político joven (menos de 50 años)
{-
        *Main> find' ((<50).edad) politicos
        Politico {proyectosPresentados = ["tolerancia 100 para delitos"], sueldo = 15500.0, edad = 49}
-}
-- b)  alguno que haya presentado más de 3 proyectos
{-
        *Main> find' ((>3).length.proyectosPresentados) politicos
        Politico {proyectosPresentados = ["ser libres","libre estacionamiento coches politicos","ley no fumar","ley 19182"], sueldo = 20000.0, edad = 81}  
-}
-- c) alguno que haya presentado algún proyecto que tenga más de 3 palabras
{-
        *Main> find' ( any ((>3).length.words).proyectosPresentados ) politicos 
        Politico {proyectosPresentados = ["ser libres","libre estacionamiento coches politicos","ley no fumar","ley 19182"], sueldo = 20000.0, edad = 81}  
-}
-- No hay que generar funciones, sino aprovechar find’ y desde la consola resuelva los tres requerimientos.
