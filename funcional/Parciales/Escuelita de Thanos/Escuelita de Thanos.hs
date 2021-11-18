import Text.Show.Functions

--------------------------------------------------- Punto 1

--Modelado de Personaje
type Habilidad = String
type Planeta = String

data Personaje = UnPersonaje {
    edad :: Int,
    energia :: Int,
    habilidades :: [Habilidad],
    nombre :: String,
    planeta :: String
} deriving (Eq, Show)

--ejemplos
ironMan = UnPersonaje {
    edad = 45,
    energia = 100,
    habilidades = ["volar", "ser millonario", "programación en Haskell"],
    nombre = "Tony",
    planeta = "Tierra"
}
spiderman = UnPersonaje {
    edad = 19,
    energia = 60,
    habilidades = ["trepar", "hacer chistes", "comerse coloradas"],
    nombre = "Peter",
    planeta = "Tierra"
}
thor = UnPersonaje {
    edad = 2000,
    energia = 300,
    habilidades = ["ser un dios", "usar Mjolnir"],
    nombre = "Thor",
    planeta = "Asgard"
}
drStrange = UnPersonaje {
    edad = 40,
    energia = 35,
    habilidades = ["ver el futuro", "teletransportarse"],
    nombre = "Stephen",
    planeta = "Tierra"
}


--Modelado de Guantelete
type Material = String

data Guantelete = UnGuantelete {
    material :: String,
    gemas :: [Gema]
}

--ejemplos
guanteletePosta = UnGuantelete{
    material = "uru",
    gemas = [mente 10, alma "ver el futuro", espacio "Endor", poder, tiempo, loca (mente 5)]
}
guanteleteTrucho = UnGuantelete{
    material = "cartón",
    gemas = [mente 10, alma "trepar", espacio "Tatooine", poder, tiempo, loca poder]
}
guanteleteVacío = UnGuantelete{
    material = "uru",
    gemas = [mente 10, alma "usar Mjolnir"]
}


--Modelado de Universo
type Universo = [Personaje]

-- ejemplo
universo1 = [ironMan, spiderman]


--Implementación de chasquido
chasquido :: Guantelete -> Universo -> Universo
chasquido guantelete universo
    | estaCompleto guantelete && esDeUru guantelete = disolverMitad universo
    | otherwise = error "no se puede disolver a la mitad de los habitantes!"

disolverMitad :: Universo -> Universo
disolverMitad universo = take (habitantes universo `div` 2) universo

habitantes = length

puedeChasquear :: Guantelete -> Bool
puedeChasquear guantelete = estaCompleto guantelete && esDeUru guantelete

estaCompleto :: Guantelete -> Bool
estaCompleto = (==6).length.gemas

esDeUru :: Guantelete -> Bool
esDeUru guantelete = material guantelete == "uru"


--------------------------------------------------- Punto 2

-- Universo apto para pendex
universoAptoParaPendex :: Universo -> Bool
universoAptoParaPendex = any ((<45).edad)

-- energia total de un universo
energiaTotal :: Universo -> Int
energiaTotal  = sum.map energia.filter masDeUnaHabilidad
-- energiaTotal universo = foldl (\acum personaje -> acum + energia personaje) 0 (filter masDeUnaHabilidad universo)
-- energiaTotal universo = foldr ((+).energia)) 0 (filter masDeUnaHabilidad universo)

masDeUnaHabilidad :: Personaje -> Bool
masDeUnaHabilidad personaje = (>1).length.habilidades $ personaje


-- ||Segunda parte||

--------------------------------------------------- Punto 3

-- Gemas:
type Gema = Personaje -> Personaje

-- La mente (debilitar la energia de un usuario en un valor dado)
mente :: Int -> Gema
mente valor = quitarEnergia valor

quitarEnergia :: Int -> Gema
quitarEnergia valor personaje = personaje {energia = energia personaje - valor}

-- El alma (eliminar una habilidad en particular si es que la posee. Además le quita 10 puntos de energia.)
alma :: Habilidad -> Gema
alma habilidad personaje = quitarEnergia 10 personaje{
    habilidades = filter (/= habilidad) $ habilidades personaje
}

-- El espacio (transportar al rival al planeta x (el que usted decida) y resta 20 puntos de energia.)
espacio :: Planeta -> Gema
espacio planetaNuevo personaje = quitarEnergia 20 personaje{
    planeta = planetaNuevo
}

-- El poder (deja sin energia al rival y si tiene 2 habilidades o menos se las quita (en caso contrario no le saca ninguna habilidad).)
poder :: Gema
poder personaje = personaje {
    energia = 0,
    habilidades = quitarHabilidades $ habilidades personaje
}

quitarHabilidades :: [Habilidad] -> [Habilidad]
quitarHabilidades habilidades   | (<=2).length $ habilidades = []
                                | otherwise = habilidades

-- El tiempo (reduce a la mitad la edad de su oponente, con un minimo de 18 años. También resta 50 puntos de energia.)
tiempo :: Gema
tiempo personaje = quitarEnergia 50 personaje {edad = (max 18.div (edad personaje)) 2}

-- La gema loca (permite manipular el poder de una gema y la ejecuta 2 veces contra un rival.)
loca :: Gema -> Gema
loca gema = gema.gema


--------------------------------------------------- Punto 4

-- Guantelete de goma
guanteleteDeGoma = UnGuantelete{
    material = "goma",
    gemas = [tiempo, alma "usar Mjolnir", loca (alma "programación en Haskell")]
}


--------------------------------------------------- Punto 5
-- No se puede utilizar recursividad.

-- Función utilizar
utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas personaje = foldr ($) personaje gemas

-- ejemplo
listaGemas = [mente 7, alma "volar", espacio "Naboo"]


--------------------------------------------------- Punto 6
--Resolver utilizando recursividad.

-- Función gemaMasPoderosa
gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa guantelete personaje = sacaMasEnergia (gemas guantelete) personaje

sacaMasEnergia :: [Gema] -> Personaje -> Gema
sacaMasEnergia [gema] _ = gema
sacaMasEnergia (gema1:gema2:gemas) personaje
    | (energia.gema1) personaje < (energia.gema2) personaje = sacaMasEnergia (gema1:gemas) personaje
    | otherwise = sacaMasEnergia (gema2:gemas) personaje


--------------------------------------------------- Punto 7
-- Dadas las siguientes funciones:
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = UnGuantelete "vesconite" (infinitasGemas tiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

-- Justifique si se puede ejecutar, relacionándolo con conceptos vistos en la cursada:
-- •    gemaMasPoderosa punisher guanteleteDeLocos

--      Nunca va a terminar de saber cual es la gema mas poderosa, porque es una lista infinita y nunca la va a terminar de reducir.
--      Entonces nunca termina de procesar. Esto pasa porque Haskell usa evaluación lazy.
--      Es decir, NO CONVERGE A UN VALOR. DIVERGE.

-- •    usoLasTresPrimerasGemas guanteleteDeLocos punisher

--      Acá no va a haber problema, porque Haskell se queda con las primeras 3, que es lo único que necesita. (Por lo mismo de la evaluación lazy).