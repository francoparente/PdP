-------------------Primeros Ejercicios Funcional-------------------

-- 1) Definir la función calcular, que recibe una tupla de 2 elementos, y devuelve una nueva tupla según las siguientes reglas:
-- ●  si el primer elemento es par lo duplica; si no lo deja como está
-- ●  si el segundo elemento es impar le suma 1; si no deja como está
-- >calcular’ (4,5)
-- (8,6)

siguiente nro = nro + 1
doble nro = nro * 2

calcular x y    | even x && odd y = (doble x, siguiente y)
                | odd x && odd y = (x, siguiente y)
                | even x && even y = (doble x, y)
                | otherwise = (x,y)

-- 2) Definir las funciones boolenas estándar. Sin usar las funciones predefinidas.
-- 2.1) Definir la función and’
and' bool1 bool2    |not bool1 = False
                    |otherwise = bool2

-- 2.2) Definir la función or’.
or' False False = False
or' _ _ = True              --El orden de las ecuaciones es importante, ya que la evaluación es secuencial.

-- 3) Definir la función notaMaxima que dado un alumno devuelva la máxima nota del alumno. (Nota resolverlo sin guardas).
type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)
notaMaxima (_,nota1,nota2,nota3) = nota1 `max` (nota2 `max` nota3)

-- 4) Definir la función cuadruple reutilizando la función doble. 
cuadruple = doble.doble
 
-- 5) Definir la función esMayorA, que verifique si el doble del siguiente de la suma entre 2 y un número es mayor a 10. 
suma :: Integer -> Integer -> Integer
(suma x) y = x + y

esMayorA :: Integer -> Bool
esMayorA nro = (>10).doble.siguiente.suma 2 $ nro

-- 6) Dar expresiones lambda que sean equivalentes a las siguientes expresiones:

--triple
triple = \nro -> nro * 3

--siguiente
siguiente' = \nro -> nro+1  --le pongo siguiente' porque ya definí una función "siguiente"

--suma
suma' = \nroA nroB -> nroA + nroB   --le pongo suma' porque ya definí una función "suma"

--sumarDos
sumarDos = \nro -> nro `suma` 2

-- 7)  Dada las siguientes definiciones:

-- 7.1)
apply f x = f x
-- ¿ A qué se reduce la siguiente expresión?.
-- > apply fst  (const 5 7, 4)
-- Respuesta: 5 (toma el primer elemento de la tupla, y const toma el primer argumento escrito)

-- 7.2)
twice f x = (f . f) x
-- ¿ A qué se reduce la siguiente expresión?.
-- >twice (`div` 2) 12
-- Respuesta: 3 (compone la función f consigo misma y a eso se le aplica x)