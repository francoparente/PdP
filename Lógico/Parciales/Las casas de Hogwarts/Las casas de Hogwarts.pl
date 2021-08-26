% -------------------------------- %
% Parte 1 - Sombrero Seleccionador %
% -------------------------------- %

% Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que el sombrero lo mande a Slytherin.
% Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso. Odiaría que el sombrero lo mande a Hufflepuff.
% Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna casa a la que odiaría ir.

%casa(Casa)
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

%sangre(Persona,Sangre)
sangre(harry,mestiza).
sangre(draco,pura).
sangre(hermione,impura).

%caracter(Persona)
caracter(harry,[corajudo, amistoso, orgulloso, inteligente]).
caracter(draco,[orgulloso, inteligente]).
caracter(hermione,[responsable, orgulloso, inteligente]).

%preferencia(Persona,Casa)
preferencia(harry,Casa).
preferencia(draco,Casa).
preferencia(hermione,Casa).