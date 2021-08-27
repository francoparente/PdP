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

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoPascua).

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

suenioPuro(Persona) :-
    suenio(Persona,serFutbolista(_)).
suenioPuro(Persona) :-
    suenio(Persona,serCantante(CantDiscosVendidos)),
    CantDiscosVendidos <200000.

%equipoChico(Equipo).
equipoChico(arsenal).
equipoChico(aldosivi).

% Punto 2
%---------

%dificultad(TipoSuenio, Dificultad).
dificultad(Persona,6) :-
    suenio(Persona,serCantante(CantDiscosVendidos)),
    CantDiscosVendidos>500000.
dificultad(Persona,4) :-
    suenio(Persona,serCantante(CantDiscosVendidos)),
    CantDiscosVendidos=<500000.

dificultad(Persona,Dificultad) :-
    suenio(Persona,ganarLoteria(SerieNumeros)),
    length(SerieNumeros,CantidadNumeros),
    Dificultad is CantidadNumeros*10.

dificultad(Persona,3) :-
    suenio(Persona,serFutbolista(Equipo)),
    equipoChico(Equipo).
dificultad(Persona,4) :-
    suenio(Persona,serFutbolista(Equipo)),
    not(equipoChico(Equipo)).

esAmbiciosa(Persona) :-
    persona(Persona),
    findall(Dificultad, dificultad(Persona, Dificultad), ListaDificultades),
    sum_list(ListaDificultades, DificultadTotal), DificultadTotal >20.

% Punto 3
%---------

hayQuimica(Persona,Personaje) :-
    persona(Persona),
    personaje(Personaje),
    cree(Persona,Personaje),
    cumpleCondiciones(Persona,Personaje).

cumpleCondiciones(Persona,campanita) :-
    suenio(Persona,_),
    dificultad(Persona,Dificultad),
    Dificultad <5.

cumpleCondiciones(Persona,campanita) :-
    forall(suenio(Persona,_), suenioPuro(Persona)),
    not(esAmbiciosa(Persona)).

% Punto 4
%---------

%amigo(Personaje,Personaje).
amigo(campanita,reyesMagos).
amigo(campanita,conejoPascua).
amigo(conejoPascua,cavenaghi).

%alegra(Personaje,Persona).
% alegra(Personaje,Persona) :- suenio(Persona,_).
alegra(Personaje,Persona) :-
    suenio(Persona,_),
    hayQuimica(Persona,Personaje),
    not(enfermo(Personaje)).
alegra(Personaje,Persona) :-
    suenio(Persona,_),
    hayQuimica(Persona,Personaje),
    backup(Backup, Personaje),
    not(enfermo(Backup)).

backup(Backup,Personaje) :-
    amigo(Backup,Personaje).
backup(Backup2,Personaje) :-
    amigo(Backup,Personaje),
    backup(Backup2,Backup).