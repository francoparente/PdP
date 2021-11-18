import Text.Show.Functions

------------------------- Punto 1

-- Modelado de chocolate

data Chocolate = Chocolate {
    nombre :: String,
    ingredientes :: [Ingrediente],
    porcentajeCacao :: Float,
    porcentajeAzucar :: Float,
    gramaje :: Float
} deriving (Show)

data Ingrediente = Ingrediente{
    nombreIngrediente :: String,
    calorias :: Int
} deriving (Show)

-- ejemplos de ingredientes

naranja = Ingrediente{
    nombreIngrediente = "naranja",
    calorias = 20
}
limon = Ingrediente{
    nombreIngrediente = "limon",
    calorias = 15
}
yogurt = Ingrediente{
    nombreIngrediente = "yogurt",
    calorias = 50
}
cookies = Ingrediente{
    nombreIngrediente = "cookies",
    calorias = 210
}
nutella = Ingrediente{
    nombreIngrediente = "nutella",
    calorias = 90
}

-- ejemplos de chocolate

chocolateDark = Chocolate{
    nombre = "Dark Force",
    ingredientes = [naranja],
    porcentajeCacao = 75,
    porcentajeAzucar = 0,
    gramaje = 25
}
chocolateMuu = Chocolate{
    nombre = "Muu",
    ingredientes = [yogurt, limon],
    porcentajeCacao = 25,
    porcentajeAzucar = 30,
    gramaje = 40
}
chocolateOreo = Chocolate{
    nombre = "Oreo",
    ingredientes = [cookies],
    porcentajeCacao = 25,
    porcentajeAzucar = 30,
    gramaje = 40
}
chocolateRocher = Chocolate{
    nombre = "Ferrero Rocher",
    ingredientes = [nutella],
    porcentajeCacao = 25,
    porcentajeAzucar = 30,
    gramaje = 40
}

-- Caja de chocolates

cajaDeChocolates = [chocolateDark, chocolateMuu, chocolateOreo, chocolateRocher]


-- Cálculo de precios

precio :: Chocolate -> Float
precio chocolate
 | chocolateAmargo chocolate = (gramaje chocolate) * precioPremium chocolate
 | (>4).length.ingredientes $ chocolate = fromIntegral((*8).length.ingredientes $ chocolate)
 | otherwise = (gramaje chocolate) * 1.5

chocolateAmargo :: Chocolate -> Bool
chocolateAmargo = (>60).porcentajeCacao

aptoDiabeticos :: Chocolate -> Bool
aptoDiabeticos chocolate = porcentajeAzucar chocolate == 0

precioPremium :: Chocolate -> Float
precioPremium chocolate
 | aptoDiabeticos chocolate = 8
 | otherwise = 5

------------------------- Punto 2

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((>200).calorias).ingredientes

totalCalorias :: Chocolate -> Int
totalCalorias chocolate = sum.map calorias.ingredientes $ chocolate

type Caja = [Chocolate]

aptoParaNinios :: Caja -> Caja
aptoParaNinios = (take 3).filter (not.esBombonAsesino)

------------------------- Punto 3

type Proceso = Chocolate -> Chocolate
type UnidadDeFruta = Int

frutalizado :: String -> UnidadDeFruta -> Proceso
frutalizado nombreFruta unidades chocolate = agregarIngrediente nombreFruta (unidades * 2) chocolate

agregarIngrediente :: String -> Int -> Chocolate -> Chocolate
agregarIngrediente nombre cantCalorias chocolate = chocolate{
    ingredientes = ingredientes chocolate ++ [Ingrediente nombre cantCalorias]
}

dulceDeLeche :: Proceso
dulceDeLeche chocolate = agregarIngrediente "Dulce de Leche" 220 chocolate{
    nombre = nombre chocolate ++ " tentacion"
}

celiaCrucera :: Float -> Proceso
celiaCrucera = agregarAzucar

agregarAzucar :: Float -> Proceso
agregarAzucar porcentaje chocolate = chocolate {
    porcentajeAzucar = porcentajeAzucar chocolate + porcentaje
}

type Grado = Int

embriagadora :: Grado -> Proceso
embriagadora grado = agregarIngrediente "Licor" (min 30 grado) . agregarAzucar 20


------------------------- Punto 4

type Receta = [Proceso]

receta :: Receta
receta = [frutalizado "Naranja" 10, dulceDeLeche, embriagadora 32]


------------------------- Punto 5

preparacion :: Chocolate -> Receta -> Chocolate
preparacion = foldr ($)


------------------------- Punto 6

type Criterio = Ingrediente -> Bool

data Persona = Persona {
    limiteDeSaturacion :: Int,
    criterio :: Criterio
}

hastaAcaLlegue :: Persona -> Caja -> Caja
hastaAcaLlegue _ [] = []
hastaAcaLlegue persona (chocolate:chocolates)
 | noQuiereComer persona chocolate = hastaAcaLlegue persona chocolates
 | (<=0).limiteDeSaturacion $ persona = []
 | otherwise = chocolate:hastaAcaLlegue (seCome persona chocolate) chocolates

seCome :: Persona -> Chocolate -> Persona
seCome persona chocolate = persona {
    limiteDeSaturacion = limiteDeSaturacion persona - totalCalorias chocolate
 }

noQuiereComer :: Persona -> Chocolate -> Bool
noQuiereComer persona = any (not.criterio persona).ingredientes


 ------------------------- Punto 6

{-
Dada una caja de chocolates infinita, la función aptoParaNinios no tendría
problemas en tomar los primeros 3 chocolates aptos. Esto pasa porque Haskell usa
lazy evaluation, entonces no necesita evaluar la totalidad de la lista infinita.

Sin embargo, la funcion totalCalorias' no podría calcular el total de calorias de
la caja, ya que dicha caja es infinita y nunca terminaría de evaluarla
-}