import Text.Show.Functions

------------------------- Punto 1

-- Persona
data Persona = UnaPersona {
    nombre :: String,
    nivelSatisfaccion :: Float,
    nivelEmocion :: Float,
    nivelCultura :: Float
} deriving Show

-- Ejemplos
ana = UnaPersona "Ana" 10 20 60
juan = UnaPersona "Juan" 20 30 40


------------------------- Punto 2

-- Atracciones
type Atraccion = Persona -> Persona
type Velocidad = Float
type Altura = Float

montañaRusa :: Velocidad -> Altura -> Atraccion
montañaRusa velocidad altura persona
 | velocidad > 50 = aumentarEmocion ((+altura).(*0.15) $ velocidad) persona
 | otherwise = disminuirSatisfaccion ((*0.1).nivelSatisfaccion $ persona) . disminuirEmocion ((*0.05).nivelEmocion $ persona) $ persona

caidaLibre :: Altura -> Atraccion
caidaLibre altura = aumentarEmocion (altura * 0.2)

mundoMaya :: Atraccion
mundoMaya persona = aumentarEmocion ((*0.1).nivelEmocion $ persona) . aumentarCultura ((*0.2).nivelCultura $ persona) $ persona

showDeMagia :: Atraccion
showDeMagia persona
 | (>50).nivelCultura $ persona = aumentarSatisfaccion 20 persona
 | otherwise = aumentarEmocion 30 persona

-- Abstracciones
aumentarEmocion :: Float -> Persona -> Persona
aumentarEmocion cantidad persona = persona {nivelEmocion = nivelEmocion persona + cantidad}

disminuirEmocion :: Float -> Persona -> Persona
disminuirEmocion cantidad = aumentarEmocion ((-1)*cantidad)

aumentarCultura :: Float -> Persona -> Persona
aumentarCultura cantidad persona = persona {nivelCultura = nivelCultura persona + cantidad}

disminuirCultura :: Float -> Persona -> Persona
disminuirCultura cantidad = aumentarCultura ((-1)*cantidad)

aumentarSatisfaccion :: Float -> Persona -> Persona
aumentarSatisfaccion cantidad persona = persona {nivelSatisfaccion = nivelSatisfaccion persona + cantidad}

disminuirSatisfaccion :: Float -> Persona -> Persona
disminuirSatisfaccion cantidad = aumentarSatisfaccion ((-1)*cantidad)


------------------------- Punto 3


visitar :: Persona -> [Atraccion] -> Persona
visitar = foldr ($)

-- Ejemplo
parque = [montañaRusa 70 25 ,caidaLibre 50, mundoMaya, showDeMagia]


------------------------- Punto 4

--atraccionInventada = (\persona -> aumentarSatisfaccion 100 persona)

-- *Main> visitar (parque ++ [(\persona -> aumentarSatisfaccion 100 persona)]) juan
-- UnaPersona {nombre = "Juan", nivelSatisfaccion = 120.0, nivelEmocion = 111.5, nivelCultura = 48.0}


------------------------- Punto 5

estanFelices :: [Persona] -> Bool
-- estanFelices personas = all estaSatisfecha . filter (estaEmocionada . montañaRusa 80 10 . mundoMaya) $ personas    --solución hecha por el ayudante
estanFelices personas = all estaSatisfecha (filter (estaEmocionada . montañaRusa 80 10 . mundoMaya) $ personas)

estaEmocionada :: Persona -> Bool
estaEmocionada = (>60).nivelEmocion

estaSatisfecha :: Persona -> Bool
estaSatisfecha = (>50).nivelSatisfaccion


------------------------- Punto 6

estaContenta :: Persona -> [Atraccion] -> Bool
estaContenta persona atracciones = contenta . visitar atracciones $ persona

contenta persona = (>100).(+ nivelEmocion persona).nivelSatisfaccion $ persona


------------------------- Punto 7

-- a) No se puede, porque debería aplicar toda la lista en la función visitar y la lista es infinita, con lo cual nunca terminaría.
-- b) Se puede gracias a la evaluación diferida de Haskell, pero depende de si en la lista infinita de personas hay una que cumpla la condición de estar contenta.