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



% --------------- Punto 4



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

:-end_tests(kioskito).