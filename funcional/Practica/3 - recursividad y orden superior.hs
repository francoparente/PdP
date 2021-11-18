-------------------Práctica Recursividad y Orden Superior-------------------

type Nombre = String

type Notas = [Int]

data Persona =   Alumno {nombre :: Nombre, notas :: Notas}
                |Persona2 {nombre :: Nombre, lugar :: String, fechaNacimiento :: (Int,Int,Int)}
-- 1. Definir la función promediosAlumnos/1, que dada una lista de alumnos devuelve una lista de tuplas que tenga el alumno y el promedio (Consideramos la división entera para el promedio y usamos la funcion div).

promedio :: Notas -> Int
promedio notas = sum notas `div` length notas

alumno1 = (Alumno "Franco" [6,7,8])
alumno2 = (Alumno "Cande" [10, 9, 8])
alumno3 = (Alumno "Frodo" [5, 10, 4])

alumnos = [alumno1, alumno2, alumno3]

promediosAlumnos alumnos = map (\unAlumno -> (nombre unAlumno, promedio.notas $ unAlumno)) alumnos

--      *Main> promediosAlumnos alumnos
--      [("Franco",7),("Cande",9),("Frodo",6)]


 -- 2. Definir la función promediosSinAplazos/1, que dada una lista de listas, devuelve la lista de los promedios de cada lista-elemento, excluyendo los que sean menores a 6 que no se cuentan.

lista1 :: [Notas]
lista1 = [[8,6,5], [9,9,8], [4,5,7]]

promediosSinAplazos :: [Notas] -> Notas
promediosSinAplazos listaNotas = map (promedio.filter (>=6)) listaNotas

--      *Main> promediosSinAplazos lista1
--      [7,8,7]
 

-- 3. Definir la función aprobó, que dado un alumno devuelve True si el alumno aprobó/1. Aclaración: se dice que un alumno aprobó si todas sus notas son 6 o más.

aprobó :: Persona -> Bool
aprobó alumno = all (>=6).notas $ alumno


--      *Main> aprobó alumno1
--      True
--      *Main> aprobó alumno2
--      True
--      *Main> aprobó alumno3
--      False

 
-- 4. Definir la función aprobaron/1, que dada una lista de alumnos, devuelve los nombres de los alumnos que aprobaron.

aprobaron :: [Persona] -> [Nombre]
aprobaron alumnos = map nombre.filter aprobó $ alumnos

--      *Main> aprobaron alumnos
--      ["Franco","Cande"]
 

-- 5. Definir la función productos que dado una lista de nombres de productos y una lista de precios, devuelve una lista de tuplas. Definirla usando zip y usando zipWith.

productos :: [String] -> [Integer] -> [(String,Integer)]
productos nombres precios = zipWith (\nom prec -> (nom,prec)) nombres precios

nombres = ["cosito1", "cosito2", "cosito3"]
precios = [100, 50, 25]

--      *Main> productos nombres precios
--      [("cosito1",100),("cosito2",50),("cosito3",25)]


-- 6. Dado una lista de flores donde cada una está representada de la siguiente forma:

data Flor= Flor{nombreFlor :: String, aplicacion:: String, cantidadDeDemanda:: Int } deriving Show

rosa     = Flor "rosa" "decorativo" 120
jazmin   = Flor "jazmin" "aromatizante" 100
violeta  = Flor "violeta" "infusión" 110
orquidea = Flor "orquidea" "decorativo" 90

flores = [orquidea, rosa,violeta, jazmin]


-- 6.a) Definir maximoSegun que permite conocer el nombre de la flor que es máxima según estos criterios. Resolverla evitando tener código duplicado y usando recursividad.

-- La cantidad demandada
-- La cantidad de letras de la flor
-- El resto de la división de la cantidad demandada por 4

maximoSegun :: (Flor -> Int) -> [Flor] -> String
maximoSegun criterio flores = nombreFlor.maximaFlorSegun criterio $ flores

maximaFlorSegun :: (Flor -> Int) -> [Flor] -> Flor
maximaFlorSegun _ [flor] = flor
maximaFlorSegun criterio (flor:flores)  | criterio flor >= criterio (maximaFlorSegun criterio flores) = flor
                                        | otherwise = maximaFlorSegun criterio flores

--      *Main> maximoSegun cantidadDeDemanda flores
--      "rosa"
--      *Main> maximoSegun (length.nombreFlor) flores
--      "orquidea"
--      *Main> maximoSegun ((mod 4).cantidadDeDemanda) flores
--      "orquidea"


-- 6 b) Dada una lista de flores determinar si están ordenadas de mayor a menor por cantidad de demanda.

ordenadaPorDemanda :: [Flor] -> Bool
ordenadaPorDemanda [_] = True
ordenadaPorDemanda (flor:otraFlor:flores) = cantidadDeDemanda flor > cantidadDeDemanda otraFlor && ordenadaPorDemanda(otraFlor:flores)

--      *Main> ordenadaPorDemanda flores
--      False


-- 7.a) - Hacer una función que dada una lista de comidas devuelva una lista con las comidas que tienen más consonantes que vocales, indicando dichas cantidades.

f1 :: [String] -> [(String,(Int,Int))]
f1 listaComidas = map (\comida -> (comida, (cantidadConsonantes comida, cantidadVocales comida))).filter (\comida -> cantidadConsonantes comida > cantidadVocales comida) $ listaComidas

vocales :: [Char]
vocales = "aeiou"++"AEIOU"

esVocal :: Char -> Bool
esVocal letra = elem letra vocales

consonantes :: [Char]
consonantes = [letra | letra <- ['a'..'z']++['A'..'Z'], (not.esVocal) letra]

esConsonante :: Char -> Bool
esConsonante letra = any (letra ==) consonantes

cantidad f comida = length.filter f $ comida

cantidadVocales :: [Char] -> Int
cantidadVocales comida = cantidad esVocal $ comida

cantidadConsonantes :: [Char] -> Int
cantidadConsonantes comida = cantidad esConsonante $ comida

comidas :: [[Char]]
comidas = ["lechuga", "anana", "alfajor de chocolate"]


--      *Main> f1 comidas
--      [("lechuga",(4,3)),("alfajor de chocolate",(10,8))]

-- 7.b) - Hacer una función que dada una lista de personas, con su nombre, lugar y fecha  de nacimiento, devuelva una lista con los nombres y la edad de quienes son menores de edad
--       (considerar menores de 18 años y calcular todas las edades al 31/12/2020).

persona1 = (Persona2 "Franquito" "Urquiza" (14,07,1996))
persona2 = (Persona2 "Candelaria" "Pilar" (27,12,1998))
persona3 = (Persona2 "Juli" "CABA" (05,03,2013))

personas = [persona1, persona2, persona3]

f2 :: [Persona] -> [(String,Int)]
f2 personas = map (\persona -> (nombre persona, edad persona)) (filter esMenor personas)

edad :: Persona -> Int
edad persona = thrd.(restarFechas (31,12,2020)).fechaNacimiento $ persona

restarFechas (d1,m1,a1) (d2,m2,a2) =  (d1-d2, m1-m2, a1-a2)

thrd (_,_,z) = z

esMenor :: Persona -> Bool
esMenor persona = edad persona < 18

--      *Main> f2 personas
--      [("Juli",7)]

-- 7.c) - Hacer una función f3 que sea de orden superior y permita obtener el mismo resultado que f1 y f2, invocandola con
--        los mismos argumentos anteriores y otros más que se consideren necesarios.

--f3 ["lechuga", "anana", "alfajor de chocolate"] <argumento/s>
--[("lechuga",(4,3),("alfajor de chocolate",(10,8)]


--f3   [Persona "Luis" "Cordoba" (20,2,2005), Persona "Pedro" "Rosario"(5,5,1940), Persona "Marta" "Mendoza" (12,10,2003)] <argumento/s>
--[("Luis",15), ("Marta",17)]


-- Nota: los otros argumentos no pueden ser f1 ni f2.