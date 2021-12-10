atiende(dodain,lunes,(9,15)).
atiende(dodain,miercoles,(9,15)).
atiende(lucas,martes,(10,20)).
atiende(juanC,sabados,(18,22)).
atiende(juanC,domingos,(18,22)).
atiende(juanFdS,jueves,(10,20)).
atiende(juanFdS,viernes,(12,20)).
atiende(leoC,lunes,(14,18)).
atiende(leoC,miercoles,(14,18)).
atiende(martu,miercoles,(23,24)).

atiende(vale,Dia,Hora) :-
    atiende(dodain,Dia,Hora).
atiende(vale,Dia,Hora) :-
    atiende(juanC,Dia,Hora).

% nadie hace el mismo horario que leoC.
% maiu está pensando si hace el horario de 0 a 8 los martes y miércoles.
% NO VA EN LA BASE DE CONOCIMIENTO POR EL PRINCIPIO DE UNIVERSO CERRADO.
