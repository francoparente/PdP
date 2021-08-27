%--------
% Sueños
%--------

% Punto 1
%---------

%persona(Persona).
persona(gabriel).
persona(juan).
persona(macarena).
persona(diego).

%personaje(Personaje).
personaje(campanita).
personaje(magoOz).
personaje(cavenaghi).
personaje(conejoPascua).
personaje(reyesMagos).
personaje(magoCapria).

%cree(Persona, Personaje).
cree(gabriel,campanita).
cree(gabriel,magoOz).
cree(gabriel,cavenaghi).
cree(juan,conejoPascua).
cree(macarena,reyesMagos).
cree(macarena,magoCapria).
cree(macarena,campanita).

%suenio(Persona,Functor).

%ganarLoteria(SerieNumeros).
%serFutbolista(Equipo).
%serCantante(CantDiscosVendidos).

suenio(gabriel,ganarLoteria([5,9])).
suenio(gabriel,serFutbolista(arsenal)).
suenio(juan,serCantante(100000)).
suenio(macarena,serCantante(10000)).

suenioPuro(serFutbolista(_)).
suenioPuro(serCantante(CantDiscosVendidos)) :- CantDiscosVendidos <200000.

%equipoChico(Equipo).
equipoChico(arsenal).
equipoChico(aldosivi).

tipoSuenio(TipoSuenio) :-
    suenio(Persona,_).

% Punto 2
%---------

%dificultad(TipoSuenio, Dificultad).
dificultad(Persona,6) :- suenio(Persona,serCantante(CantDiscosVendidos)), CantDiscosVendidos>500000.
dificultad(Persona,4) :- suenio(Persona,serCantante(CantDiscosVendidos)), CantDiscosVendidos=<500000.

dificultad(Persona,Dificultad) :- suenio(Persona,ganarLoteria(SerieNumeros)), length(SerieNumeros,CantidadNumeros), Dificultad is CantidadNumeros*10.

dificultad(Persona,3) :- suenio(Persona,serFutbolista(Equipo)), equipoChico(Equipo).
dificultad(Persona,4) :- suenio(Persona,serFutbolista(Equipo)), not(equipoChico(Equipo)).

esAmbiciosa(Persona) :- persona(Persona), findall(Dificultad,dificultad(Persona,Dificultad),DificultadTotal), sum_list(DificultadTotal,Suma), Suma >20.

% Punto 3
%---------

hayQuimica(Persona,campanita) :- cree(Persona,campanita), dificultad(Persona,Dificultad), Dificultad <5.
hayQuimica(Persona,Personaje) :- cree(Persona,Personaje), suenio(Persona,Suenio), suenioPuro(Suenio), not(esAmbiciosa(Persona)).
