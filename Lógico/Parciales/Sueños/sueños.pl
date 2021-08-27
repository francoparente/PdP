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
%serFutbolista(Equipo).
%serCantante(CantDiscosVendidos).

suenio(gabriel,ganarLoteria([5,9])).
suenio(gabriel,serFutbolista(arsenal)).
suenio(juan,serCantante(100000)).
suenio(macarena,serCantante(10000)).

%equipoChico(Equipo).
equipoChico(arsenal).
equipoChico(aldosivi).

tipoSuenio(TipoSuenio) :-
    suenio(Persona,_).

%dificultad(TipoSuenio, Dificultad).
dificultad(Persona,6) :- suenio(Persona,serCantante(CantDiscosVendidos)), CantDiscosVendidos>500000.
dificultad(Persona,4) :- suenio(Persona,serCantante(CantDiscosVendidos)), CantDiscosVendidos=<500000.

dificultad(Persona,Dificultad) :- suenio(Persona,ganarLoteria(SerieNumeros)), length(SerieNumeros,CantidadNumeros), Dificultad is CantidadNumeros*10.

dificultad(Persona,3) :- suenio(Persona,serFutbolista(Equipo)), equipoChico(Equipo).
dificultad(Persona,4) :- suenio(Persona,serFutbolista(Equipo)), not(equipoChico(Equipo)).

esAmbiciosa(Persona) :- persona(Persona), findall(Dificultad,dificultad(Persona,Dificultad),DificultadTotal), sum_list(DificultadTotal,Suma), Suma >20.
