-------------------La medicina del Futuro-------------------

--Un laboratorio está experimentando con distintos ratones para crear nuevos medicamentos naturales.
--De los ratones que usan se conoce nombre, edad,  su peso, y las enfermedades que posee.

data Animal= Raton {nombre :: String, edad :: Float, peso :: Float, enfermedades :: [String]} deriving Show

-- Ejemplo de raton
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]

-- Estos son las enfermedades infecciosas
enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]


--Recuerde aprovechar Orden Superior, Aplicación Parcial, Listas por Comprensión, Composición de funciones y Expresiones Lambda.

{- 1) Hacer 4 funciones de modificación del ratón: modificarNombre, modificarEdad, modificarPeso, modificarEnfermedades.
      Deben recibir una función y un ratón, y devolver el ratón modificado.

    Ejemplos:
        > modificarEdad (*2) cerebro
        Raton "Cerebro" 18.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]

        > modificarNombre (++ " el genio") cerebro
        Raton "Cerebro el genio" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"] -}


{- 2) Existen distintos tipos de hierbas que afectan de diferentes maneras al ratón. Definir dichas hierbas:
        a)  hierbaBuena, que rejuvenece al ratón a la raíz cuadrada de su edad.
            Por ejemplo, si a cerebro le doy hierbaBuena, se transforma en un ratón de 3 años.
        b)  hierbaVerde, elimina una enfermedad dada.
            Por ejemplo, si a cerebro le doy la hierbaVerde para la  “brucelosis”, queda con sarampión y con tuberculosis.
        c)  alcachofa, hace que el ratón pierda peso en un 10% si pesa más de 2kg, sino pierde un 5%.
            Por ejemplo, un ratón de 3 kg queda con 2,7 kg y cerebro queda con 0.19 kg.
        d)  hierbaMagica, hace que el ratón pierda todas sus infecciones y quede con 0 años de edad. -}

{- 3) Medicamentos:
        a)  Hacer la función medicamento, que recibe una lista de hierbas, un ratón, y administra al ratón todas las hierbas.

        b)  Hacer antiAge que es un medicamento que está hecho con 3 hierbas buenas y una alcachofa.
            > antiAge (Raton "bicenterata" 256.0 0.2 [])
            Raton "bicenterata" 2.0 0.19 []

        c)  Hacer reduceFatFast  (que viene en distintas potencias) y es un medicamento compuesto por una hierbaVerde de “obesidad” y tantas alcachofas como indique su potencia.  
            > reduceFatFast 1 (Raton “Orejudo" 4.0 10.0 ["obesidad", "sinusitis"])
            Raton "Orejudo" 4.0 9.0 ["sinusitis"]
            > reduceFatFast 2 (Raton "Orejudo" 4.0 10.0 [“obesidad", "sinusitis"])
            Raton "Orejudo" 4.0 8.1 ["sinusitis"]

        d)  Hacer la función hierbaMilagrosa, que es un medicamento que usa hierbasVerdes para curar todas las enfermedades infecciosas. -}

{- 4) Experimentos:
      Los laboratorios antes de publicar un medicamento, lo prueban con distintos ratones para evaluar los resultados:
      
        a)  Hacer la función que encuentra la cantidadIdeal. Recibe una condición y dice cuál es el primer número natural que la cumple.
            > cantidadIdeal even           > cantidadIdeal (>5)
            2                              6

        b)  Hacer la función estanMejoresQueNunca que dado un conjunto de ratones y un medicamento,
            es cierto cuando cada uno pesa menos de 1 kg después de aplicarle el medicamento dado.

        c)  Diseñar el siguiente experimento: dado un conjunto de ratones,  encontrar la potencia ideal del reduceFatFast
            necesaria para que todos estén mejores que nunca. -}