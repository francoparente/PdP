-------------------Práctica Orden Superior - Fold-------------------



-- 1) Dada una lista de tuplas, sacar la cantidad de elementos utilizando foldl y foldr.
-- Main>cantidadDeElementos [(8,6),(5,5),(5,6),(7,8)]
-- 4
    cantidadDeElementosL lista = foldl (\ sem _ -> sem+1) 0 lista

    cantidadDeElementosR lista = foldr (\ _ sem -> sem+1) 0 lista



-- 2) Dada una lista de pares (empleado, gasto), conocer el empleado más gastador usando foldl y foldr.
-- Main>masGastador [("ana",80),("pepe",40),("juan",300),("maria",120)]
-- ("juan",300)
    masGastadorL (empleado:empleados) = foldl maxEntre empleado empleados

    masGastadorR (empleado:empleados) = foldr maxEntre empleado empleados

    maxEntre empleado1 empleado2    | snd empleado1 > snd empleado2 = empleado1
                                    | otherwise = empleado2



-- 3) Dada una lista de (empleado, gasto), conocer el gasto total usando foldl y foldr.
-- Main>monto [("ana",80),("pepe",40),("juan",300),("maria",120)]
-- 540
    montoL empleados = foldl (\ sem empleado -> sem + snd empleado) 0 empleados

    montoR empleados = foldr (\ empleado sem -> sem + snd empleado) 0 empleados



-- 4) Completar con lo que corresponda para:
    -- >foldl …. 2 [(3+), (*2), (5+)]
    -- 15
        -- Rta1:     foldl (\ sem f -> f sem) 2 [(3+), (*2), (5+)]      esta la hice yo
        -- Rta2:     foldl (flip ($)) 2 [(3+), (*2), (5+)]              esta la hizo la profe

    -- >foldr …. 2 [(3+), (*2), (5+)]
    -- 17
        -- Rta1:     foldr (\ f sem -> f sem) 2 [(3+), (*2), (5+)]      esta la hice yo
        -- Rta2:     foldr ($) 2 [(3+), (*2), (5+)]                     esta la hizo la profe


-- 5) Dada una lista de proyectos:

    type Nombre  = String
    type InversionInicial = Int
    type Profesionales = [String]

    data  Proyecto = Proy {nombre:: Nombre, inversionInicial::  InversionInicial, profesionales:: Profesionales} deriving Show

    proyectos = [   Proy "red social de arte"  20000 ["ing. en sistemas", "contador"], 
                    Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"],
                    Proy "ventaChurros" 1000 ["cocinero"] ]

-- 5.1) Determine, usando foldl y foldr, una función que permita conocer el máximo proyecto según a), b) y c). Muestre por cada caso ejemplos de invocación y respuesta.


-- //USO foldl1 porque es más sencillo, MÁS ABAJO LO HAGO COMO LO PIDE LA CONSIGNA.//

    maximoSegun criterio proyectos = foldl1 (maximoProyecto criterio) proyectos

    maximoProyecto criterio proyecto1 proyecto2     | criterio proyecto1 > criterio proyecto2 = proyecto1
                                                    | otherwise = proyecto2

-- a) La inversión inicial

    criterioA = inversionInicial
    -- *Main> maximoSegun criterioA proyectos
    -- Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}

-- b) El nro de profesionales.

    criterioB = length.profesionales
    -- *Main> maximoSegun criterioB proyectos
    -- Proy {nombre = "restaurante", inversionInicial = 5000, profesionales = ["cocinero","adm. de empresas","contador"]}

-- c) La cantidad de palabras del proyecto.

    criterioC = length.words.nombre
    -- *Main> maximoSegun criterioC proyectos
    -- Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}


-- //A CONTINUACIÓN ESTA HECHO USANDO RECURSIVIDAD (en clase).//
{-
    maximoSegun' :: [Proyecto] -> (Proyecto -> Int) -> Proyecto
    maximoSegun' [proyecto] _ = proyecto
    maximoSegun' (unProyecto:proyectos) criterio    | criterio unProyecto > criterio (maximoSegun' proyectos criterio)  = unProyecto
                                                    | otherwise = maximoSegun' proyectos criterio
-}


-- //A CONTINUACIÓN ESTA HECHO SIN ABSTRACCIONES Y CON AMBAS FUNCIONES foldl y foldr.//
{-
    -- a) La inversión inicial

        mayorInversionL (proyecto:proyectos) = foldl maxInversion proyecto proyectos
        --  *Main> mayorInversionL proyectos     
        --  Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}

        mayorInversionR (proyecto:proyectos) = foldr maxInversion proyecto proyectos
        --  *Main> mayorInversionR proyectos
        --  Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}

        maxInversion proyecto1 proyecto2    | inversionInicial proyecto1 > inversionInicial proyecto2 = proyecto1
                                            | otherwise = proyecto2

    -- b) El nro de profesionales.

        masProfesionalesL (proyecto:proyectos) =  foldl maxProfesionales proyecto proyectos
        --  *Main> masProfesionalesL proyectos
        --  Proy {nombre = "restaurante", inversionInicial = 5000, profesionales = ["cocinero","adm. de empresas","contador"]}

        masProfesionalesR (proyecto:proyectos) =  foldr maxProfesionales proyecto proyectos
        --  *Main> masProfesionalesR proyectos
        --  Proy {nombre = "restaurante", inversionInicial = 5000, profesionales = ["cocinero","adm. de empresas","contador"]}

        maxProfesionales proyecto1 proyecto2    | (length.profesionales $ proyecto1) > (length.profesionales $ proyecto2) = proyecto1
                                                | otherwise = proyecto2

    -- c) La cantidad de palabras del proyecto.

        masPalabrasL (proyecto:proyectos) =  foldl maxPalabrasProyecto proyecto proyectos
        --  *Main> masPalabrasL proyectos
        --  Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}

        masPalabrasR (proyecto:proyectos) =  foldr maxPalabrasProyecto proyecto proyectos
        --  *Main> masPalabrasR proyectos
        --  Proy {nombre = "red social de arte", inversionInicial = 20000, profesionales = ["ing. en sistemas","contador"]}

        maxPalabrasProyecto proyecto1 proyecto2     | (length.words.nombre $ proyecto1) > (length.words.nombre $ proyecto2) = proyecto1
                                                    | otherwise = proyecto2
-}