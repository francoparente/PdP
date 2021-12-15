import Text.Show.Functions()
                                                
-- Dominio --
type Sueño = Persona -> Persona

data Persona = Persona {edad :: Int, sueños:: [Sueño], nombre:: String, felicidonios:: Int, habilidades:: [String] } deriving Show

-- Definiciones de personas para las pruebas --

persona1 = Persona 25 [recibirseDe "Sistemas", viajarA ["Tailandia"]] "Guadalupe" 101 []

persona2 = Persona 26 [viajarA ["París", "Moscú"], recibirseDe "Arte" ] "Maximiliano" 100 ["Bailar"]

persona3 = Persona 89 [enamorarseDe persona4] "Evangelina" 50 ["Bailar", "Estudiar"]

persona4 = Persona 26 [todoSigueIgual] "Ariel" 14 ["Bailar"]

persona5 = Persona 89 [comboPerfecto] "Melina" 12 ["Bailar", "Estudiar"]

lista_personas = [persona1, persona2, persona3, persona4, persona5]                                        

                                        ---- PUNTO 1 ----


-- Abstracciones Punto 1--
mayorA100 felicidonios = felicidonios > 100
mayorA50 felicidonios = felicidonios > 50

felicidoniosPorCantSueños :: Persona -> Int
felicidoniosPorCantSueños persona = ((felicidonios persona) *).cantidadDeSueños $ persona

cantidadDeSueños :: Persona -> Int
cantidadDeSueños persona = length.sueños $ persona

-- Punto A --
coeficienteDeSatisfaccion :: Persona -> Int
coeficienteDeSatisfaccion persona   | mayorA100.felicidonios $ persona  = ((felicidonios persona) *).edad $ persona
                                    | mayorA50.felicidonios $ persona = felicidoniosPorCantSueños persona
                                    | otherwise = div (felicidonios persona) 2

-- Punto B --
gradoDeAmbicion :: Persona -> Int
gradoDeAmbicion persona | mayorA100.felicidonios $ persona  = felicidoniosPorCantSueños persona
                        | mayorA50.felicidonios $ persona = ((edad persona) *).cantidadDeSueños $ persona
                        | otherwise = (2 *).cantidadDeSueños $ persona



                                        ---- PUNTO 2 ----


-- Punto A --
nombreLargo :: Persona -> Bool
nombreLargo persona = (10 <).length.nombre $ persona

-- Punto B --
personaSuertuda :: Persona -> Bool
personaSuertuda persona = even.(3*).coeficienteDeSatisfaccion $ persona

-- Punto C --
nombreLindo :: Persona -> Bool
nombreLindo persona = ('a'==).last.nombre $ persona 



                                        ---- PUNTO 3 ----


-- Abstracciones Punto 3 --
incrementarFelicidonios :: Int -> Persona -> Persona
incrementarFelicidonios cantidad persona = persona { felicidonios = ((+cantidad).felicidonios) $ persona }
    
agregarHabilidad :: [Char] -> Persona -> Persona
agregarHabilidad carrera persona = persona { habilidades = ([carrera]++).habilidades $ persona }

-- Punto A --
recibirseDe :: String -> Persona -> Persona
recibirseDe carrera persona = (incrementarFelicidonios ((1000*).length $ carrera)).(agregarHabilidad carrera) $ persona 

-- Punto B --
sumarUnAño :: Persona -> Persona
sumarUnAño persona = persona { edad = (+1).edad $ persona }

viajarA :: [String] -> Persona -> Persona
viajarA ciudades persona = sumarUnAño.(incrementarFelicidonios ((100*).length $ ciudades)) $  persona

-- Punto C --
enamorarseDe :: Persona -> Persona -> Persona
enamorarseDe otraPersona persona = incrementarFelicidonios (felicidonios otraPersona) persona

-- Implementaciones comunes --
todoSigueIgual :: Persona -> Persona
todoSigueIgual = id

comboPerfecto :: Persona -> Persona
comboPerfecto persona = (incrementarFelicidonios 100).(viajarA ["Paris", "Berazategui"]).(recibirseDe "Medicina") $ persona

                        
                                        --- PUNTO 4 ---

type Fuente = Persona -> Persona 

cumplirSueño :: Int -> Fuente --cumple el n-esimo sueño
cumplirSueño n persona = ((!!) (sueños persona) n ) $ persona

-- Punto A -- 
fuenteMinimalista :: Fuente
fuenteMinimalista persona = eliminarPrimerSueño.(cumplirSueño 0) $ persona

eliminarPrimerSueño :: Persona -> Persona
eliminarPrimerSueño persona = persona {sueños = tail.sueños $ persona}

-- Punto B --
fuenteCopada :: Fuente
fuenteCopada persona = (eliminarSueños).(foldl (flip($)) persona.sueños) $ persona

eliminarSueños :: Fuente
eliminarSueños persona = persona{sueños = []}

-- Punto C --
fuenteAPedido :: Int -> Fuente
fuenteAPedido = cumplirSueño

-- Punto D --
fuenteSorda :: Fuente
fuenteSorda  = todoSigueIgual 


                                        --- PUNTO 5 ---

fuenteGanadora :: [Fuente] -> Persona -> (Persona -> Int) -> Fuente
fuenteGanadora fuentes persona criterio  = foldl1 (cualEsMayorSegun persona criterio ) fuentes 


cualEsMayorSegun :: Persona -> (Persona -> Int) -> Fuente -> Fuente -> Fuente
cualEsMayorSegun persona criterio fuente1 fuente2   | (criterio.fuente1 $ persona) > (criterio.fuente2 $ persona) = fuente1 
                                                    | otherwise = fuente2 

                                        --- PUNTO 6 ---

--- Punto A ---
sueñoValioso :: Persona -> [Sueño]
sueñoValioso persona = filter (esValioso persona) (sueños persona)

esValioso :: Persona -> Sueño -> Bool
esValioso persona sueño = (>100).felicidonios.sueño $ persona

--- Punto B ---
sueñoRaro :: Persona -> Bool
sueñoRaro persona = any (esRaro persona) (sueños persona)
esRaro :: Persona -> Sueño -> Bool
esRaro persona sueño = (== felicidonios persona).felicidonios.sueño $ persona

--- Punto C --- 
felicidadTotalGrupo :: [Persona] -> Int
felicidadTotalGrupo personas = foldr ((+).felicidonios.fuenteCopada) 0 personas

                                        --- PUNTO 7 ---

personaSueñosInfinitos = Persona 30 sueñosInfinitos "Ariel" 14 ["Bailar"]

sueñosInfinitos :: [Sueño]
sueñosInfinitos = repeat (viajarA ["Paris"])
