-------------------Práctica Funcional - Tipos-------------------


--a) Determinar para cada una de los funciones.
-- ¿ Qué hace ? Dar el prototipo/tipo de las funciones

--1) p n = (head . filter n)


--2) f x y = (x.fst.head) y > (x.snd.head) y


--3) g f a b = f a == f b


--4) p1 x y z = ((> z) . length . filter x . map y)


--5) h nom  = head.filter ((nom==).g1)
--   g1 (_, c, _) = c


--6) f2 x _ [] = x
--   f2 x y (z:zs)  | y z > 0 = z + f2 x y zs
--                  | otherwise = f2 x y zs


--7) f3 a b (c:cs)  | a > c = f3 a b cs
--                  | otherwise = b c


--8) f4 a b c d e | (a . d e) (1, True) = 0
--                | otherwise = length (b:c) + e




--9) g2 f x l = (head . filter ((x==).f)) l


--10) qfsort f [ ] = [ ]
--    qfsort f (x:xs) = (qfsort f (filter ((> f x).f) xs)) ++ [x] ++ (qfsort f (filter ((< f x).f) xs))


--11) floca g f n | (g . f ) n = n : floca g f (n + 1)
--                | otherwise = floca g f (n + 1)


--12) g3 k p r = all (p r) . filter ((> r).k)


--13) f5 h r x =   any (h==) . map (\(_,z) -> r x z)