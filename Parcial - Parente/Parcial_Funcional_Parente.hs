import Text.Show.Functions

------------------------- Punto 1

--a)

data Pokemon = Pokemon{
    nombre :: String,
    tipo :: String,
    nivel :: Float,
    fuerza :: Float,
    actividades :: [Actividad],
    habilidades :: [Habilidad]
} deriving Show

type Habilidad = String

-- b)

pikachu :: Pokemon
pikachu = Pokemon "Pikachu" "Electrico" 55 38 [caminadora 60 10] ["Impactrueno", "Placaje Electrico"]

-- c)

snorlax :: Pokemon
snorlax = Pokemon "Snorlax" "Normal" 30 80 [dormirSiesta 10, levantarPesas 30] ["Bostezo", "Golpe Cuerpo"]


------------------------- Punto 2

type Actividad = Pokemon -> Pokemon

dormirSiesta :: Float -> Actividad
dormirSiesta horas pokemon
 | horas < 5 = aumentarFuerza (10*horas) pokemon
 | otherwise = disminuirNivel 1 pokemon

caminadora :: Float -> Float -> Actividad
caminadora minutos velocidad pokemon = aumentarFuerza ((minutos / 15) * velocidad) pokemon

levantarPesas :: Float -> Actividad
levantarPesas peso pokemon
 | (<peso).fuerza $ pokemon = aumentarNivel 1 . aumentarFuerza peso $ pokemon
 | otherwise = disminuirFuerza ((*0.1).fuerza $ pokemon) pokemon

darPaseo :: Actividad
darPaseo = id

-- Abstracciones

aumentarFuerza :: Float -> Actividad
aumentarFuerza cantidad pokemon = pokemon {fuerza = fuerza pokemon + cantidad}

disminuirFuerza :: Float -> Actividad
disminuirFuerza cantidad = aumentarFuerza ((-1)*cantidad)

aumentarNivel :: Float -> Actividad
aumentarNivel cantidad pokemon = pokemon {nivel = nivel pokemon + cantidad}

disminuirNivel :: Float -> Actividad
disminuirNivel cantidad = aumentarNivel ((-1)*cantidad)

agregarHabilidad :: Habilidad -> Actividad
agregarHabilidad habilidad pokemon = pokemon {habilidades = habilidades pokemon ++ [habilidad]}

perderHabilidades :: Actividad
perderHabilidades pokemon = pokemon {actividades = []}

------------------------- Punto 3

-- a)

rutinaSuperEntrenamiento :: Actividad
rutinaSuperEntrenamiento pokemon = agregarHabilidad "Patada alta" . (realizarRutina.actividades $ pokemon) . realizarRutina superEntrenamiento $ pokemon

type Rutina = [Actividad]

superEntrenamiento :: Rutina
superEntrenamiento = [caminadora 60 6, levantarPesas 15]

realizarRutina :: Rutina -> Actividad
realizarRutina rutina pokemon = foldr ($) pokemon rutina


-- b)

rutinaTranqui :: Actividad
rutinaTranqui = perderHabilidades.realizarRutina tranqui

tranqui :: Rutina
tranqui = [darPaseo, dormirSiesta 2]


-- c)

rutinaInventada :: Actividad
rutinaInventada = (\pokemon -> (agregarHabilidad "Promoción directa".aumentarNivel 10 $ pokemon))


------------------------- Punto 4

-- a)

realizarRutinas :: [Rutina] -> Pokemon -> Pokemon
realizarRutinas (rutina:rutinas) pokemon = realizarRutina rutina (realizarRutina rutina pokemon)

listaRutinas = [superEntrenamiento, tranqui]

-- b)

pokemonsRealizanRutina :: [Pokemon] -> Rutina -> [Pokemon]
pokemonsRealizanRutina pokemons rutina = map (realizarRutina rutina) pokemons

-- c)

esPotente :: Float -> Pokemon -> Bool
esPotente n = (>n).poderDeCombate

poderDeCombate :: Pokemon -> Float
poderDeCombate pokemon = ((fuerza pokemon) + (nivel pokemon)) / 2
-- poderDeCombate = (/2).(+).(fuerza pokemon) (nivel pokemon)       Quise usar composición pero me tiraba error, lo dejo acá igual.

-- d)

quedanOrdenados :: [Pokemon] -> Bool
quedanOrdenados (pokemon:pokemons) = filter (fuerza pokemon > fuerza.head pokemons) (map (rutinaSuperEntrenamiento . rutinaTranqui) pokemons)


------------------------- Punto 5

-- 1)

informePoder :: [Pokemon] -> [Rutina] -> [Rutina]
informePoder pokemons rutinas = filtrarRutinas poderDeCombateMenorA60

informeFueza :: [Pokemon] -> [Rutina] -> [Rutina]
informeFueza pokemons rutinas = filtrarRutinas fuerzaMayorA50 

informeNivel :: [Pokemon] -> [Rutina] -> [Rutina]
informeNivel pokemons rutinas = filtrarRutinas nivelMenorA10 


filtrarRutinas :: Condicion -> [Rutina] -> [Pokemon] -> [Pokemon]
filtrarRutinas condicion rutinas pokemons = filter (condicion) (realizarRutinas rutinas pokemons)

type Condicion = Pokemon -> Bool

poderDeCombateMenorA60 :: Pokemon -> Bool
poderDeCombateMenorA60 = (<60).poderDeCombate

fuerzaMayorA50 :: Pokemon -> Bool
fuerzaMayorA50 = (>50).fuerza

nivelMenorA10 :: Pokemon -> Bool
nivelMenorA10 = (<10).nivel


------------------------- Punto 6

charmander :: Pokemon
charmander = Pokemon "Charmander" "Fuego" 30 40 (repeat (dormirSiesta 2)) []

-- ¿Se podría aplicar el pokemon del punto a) en alguna de la funciones del parcial de manera que dicha función termine ?.
-- Si se puede dar ejemplos de invocación y respuesta y justificar. Si no se puede justificar porque.

{-
Se podría aplicar este pokemon en la función rutinaTranqui, ya que al tener evaluación lazy por defecto, Haskell tomaría solo lo que necesita.
En este caso no necesita reducir la lista de actividades del pokemon, ya que no se usa en la función. Sin embargo si se quisiera aplicar el pokemon
a la función rutinaSuperEntrenamiento, esta nunca terminaría de procesar la lista de actividades que necesita, ya que es infinita.

*Main> rutinaTranqui charmander
Pokemon {nombre = "Charmander", tipo = "Fuego", nivel = 30.0, fuerza = 60.0, actividades = [], habilidades = []}

*Main> rutinaSuperEntrenamiento charmander
*** Exception: stack overflow
-}
