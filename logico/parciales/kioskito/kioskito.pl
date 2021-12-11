% --------------- Base de conocimiento

atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).

atiende(lucas,martes,10,20).

atiende(juanC,sabado,18,22).
atiende(juanC,domingo,18,22).

atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).

atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).

atiende(martu,miercoles,23,24).

% --------------- Punto 1

atiende(vale,Dia,Desde,Hasta) :-
    atiende(dodain,Dia,Desde,Hasta).
atiende(vale,Dia,Desde,Hasta) :-
    atiende(juanC,Dia,Desde,Hasta).

% nadie hace el mismo horario que leoC.
% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles.
% NO VA EN LA BASE DE CONOCIMIENTO POR EL PRINCIPIO DE UNIVERSO CERRADO.

% --------------- Punto 2

quienAtiende(Persona,Dia,Hora) :-
    atiende(Persona,Dia,HoraInicio,HoraFin),
    between(HoraInicio,HoraFin,Hora).

% --------------- Punto 3

foreverAlone(Persona,Dia,Hora) :-
    quienAtiende(Persona,Dia,Hora),
    not((quienAtiende(Alguien,Dia,Hora), Alguien \= Persona)).

% --------------- Punto 4

persona(Persona) :-
    atiende(Persona,_,_,_).
dia(Dia) :-
    atiende(_,Dia,_,_).

posibilidadDeAtencion(Dia,Personas) :-
    findall(Persona, distinct(Persona, quienAtiende(Persona,Dia,Hora)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).

combinar([],[]).

combinar([Persona|PersonasPosibles],[Persona|Personas]) :-
    combinar(PersonasPosibles, Personas).

combinar([_|PersonasPosibles], Personas) :-
    combinar(PersonasPosibles, Personas).

% --------------- Punto 5



% --------------- Tests

:- begin_tests(kioskito).

test(atienden_los_viernes, set(Persona = [vale,dodain,juanFdS])):-
    atiende(Persona,viernes,_,_).

test(personas_que_atienden_un_dia_y_hora_determinada, set(Persona = [vale, dodain, leoC])) :-
    quienAtiende(Persona,lunes,14).
test(personas_que_atienden_un_dia_y_hora_determinada, set(Persona = [vale, juanC])) :-
    quienAtiende(Persona,sabado,18).

test(atiende_a_una_hora_determinada, true) :-
    quienAtiende(juanFdS,jueves,11).

test(dias_que_atiende_una_persona_en_un_horario_determinado, set(Dia = [lunes,miercoles,viernes])) :-
    quienAtiende(vale,Dia,10).

test(persona_esta_forever_alone_en_hora_determinada_porque_atiende_sola, set(Persona = [lucas])) :-
    foreverAlone(Persona,martes,19).
% test(atiende_solo_en un horario_determinado, set(Persona = [juanFdS])) :-
%     foreverAlone(Persona,jueves,10).
test(persona_no_esta_forever_alone_si_no_atiende_en_hora_determinada, fail) :-
    foreverAlone(martu,miercoles,22).
% test(atiende_solo_en un horario_determinado, true) :-
%     foreverAlone(martu,miercoles,23).
% test(atiende_solo_en un horario_determinado, false) :-
%     foreverAlone(dodain,lunes,10).

test(posibilidades_de_atencion_en_un_dia_muestra_todas_las_combinaciones_posibles, set(Personas=[[],[dodain],[dodain,leoC],[dodain,leoC,martu],[dodain,leoC,martu,vale],[dodain,leoC,vale],[dodain,martu],[dodain,martu,vale],[dodain,vale],[leoC],[leoC,martu],[leoC,martu,vale],[leoC,vale],[martu],[martu,vale],[vale]])) :-
    posibilidadDeAtencion(miercoles,Personas).

:-end_tests(kioskito).