%--------
% Sueños
%--------

% Punto 1

%persona(Persona).
persona(gabriel).
persona(juan).
persona(macarena).
persona(diego).

%creencia(Creencia).
creencia(campanita).
creencia(magoOz).
creencia(cavenaghi).
creencia(conejoPascua).
creencia(reyesMagos).
creencia(magoCapria).

%cree(Persona, Creencia).
cree(gabriel,campanita).
cree(gabriel,magoOz).
cree(gabriel,cavenaghi).
cree(juan,conejoPascua).
cree(macarena,reyesMagos).
cree(macarena,magoCapria).
cree(macarena,campanita).

%suenio(Persona,Functor).
%ganarLoteria(SerieNumeros).
%serFutbolista(NombreEquipo).
%serCantante(CantDiscosVendidos).

suenio(gabriel,ganarLoteria([5,9])).
suenio(gabriel,serFutbolista(arsenal)).
suenio(juan,serCantante(100000)).
suenio(macarena,serCantante(10000)).

%dificultad(TipoSuenio, Dificultad).
dificultad(serCantante(CantDiscos),6) :- CantDiscos >500000.
dificultad(serCantante(CantDiscos),4) :- CantDiscos =<500000.