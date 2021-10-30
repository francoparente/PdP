% -------
% Punto 1
% -------

transporte(colectivo(132,plazaFlores)).
transporte(subte).

%transita(Functor, Barrio).
transita(colectivo(7,samore), retiro).
transita(colectivo(7,samore), monserrat).
transita(colectivo(7,samore), balvanera).
transita(colectivo(7,samore), boedo).
transita(colectivo(7,samore), parqueChacabuco).
transita(colectivo(7,samore), flores).
transita(colectivo(7,samore), barrioSamore).

transita(colectivo(101,retiro), retiro).
transita(colectivo(101,retiro), balvanera).
transita(colectivo(101,retiro), parquePatricios).
transita(colectivo(101,retiro), flores).
transita(colectivo(101,retiro), barrioSamore).

transita(colectivo(132,plazaFlores), flores).
transita(colectivo(132,plazaFlores), caballito).
transita(colectivo(132,plazaFlores), balvanera).
transita(colectivo(132,plazaFlores), retiro).

transita(subte(e), monserrat).
transita(subte(e), constitucion).
transita(subte(e), boedo).
transita(subte(e), parqueChacabuco).
transita(subte(e), flores).

transita(subte(a), monserrat).
transita(subte(a), caballito).
transita(subte(a), flores).

%conductor(Conductor).
conductor(marcela).
conductor(pablo).
conductor(cecilia).
conductor(mariano).
conductor(juan).

%conduce(Functor, Conductor).
conduce(subte(a), marcela).
conduce(colectivo(7,samore), pablo).
conduce(colectivo(101,retiro), pablo).
conduce(colectivo(101,retiro), cecilia).
conduce(subte(a), mariano).
conduce(subte(e), mariano).

%usuarios(Usuario).
usuario(pepe).
usuario(julian).
usuario(judith).
usuario(clara).
usuario(ignacio).
usuario(pedro).

%viaja(Usuario, Functor).
viaja(pepe, colectivo(101,retiro)).
viaja(julian, subte(e)).
viaja(julian, subte(a)).
viaja(judith, colectivo(7,samore)).
viaja(clara, colectivo(101,retiro)).
viaja(ignacio, subte(e)).
viaja(ignacio, subte(a)).
viaja(ignacio, colectivo(7,samore)).

% -------
% Punto 2
% -------

comoViajarA(Barrio1, Barrio2, Transporte) :-
    transita(Transporte, Barrio1),
    transita(Transporte, Barrio2).

% unicoMedioDeTransporte(Transporte, Barrio).

% -------
% Punto 3
% -------

compartenElMismoCamino(Usuario1, Usuario2) :-
    viaja(Usuario1, Transporte),
    viaja(Usuario2, Transporte).

compartenElMismoCamino(Usuario1, Usuario2) :-
    viaja(Usuario1, Transporte1),
    viaja(Usuario2, Transporte2),
    dosBarrios(Transporte1,Transporte2).

dosBarrios(Transporte1, Transporte2) :-
    transita(Transporte1, Barrio1),
    transita(Transporte2, Barrio1),
    transita(Transporte1, Barrio2),
    transita(Transporte2, Barrio2).


% -------
% Punto 4
% -------

viajaBien(Usuario) :-
    usuario(Usuario),
    forall(viaja(Usuario, Transporte), buenaFrecuencia(Transporte)).

buenaFrecuencia(colectivo(132,_)).
buenaFrecuencia(subte(_)).

% -------
% Punto 5
% -------

conoce(ignacio, julian).
conoce(judith, clara).
conoce(clara, pepe).

conocido(Usuario1, Usuario2) :-
    conoce(Usuario1, Usuario2).

conocido(Usuario3,Usuario2) :-
    conoce(Usuario1,Usuario2),
    conocido(Usuario3,Usuario1).

viajaSolo(Usuario) :-
    forall(conocido(Usuario,Usuario2), not(compartenElMismoCamino(Usuario, Usuario2))).


% -------
% Punto 6
% -------

esRecomendable(Transporte) :-
    buenaFrecuencia(Transporte),
    findall(Usuario, viaja(Usuario, Transporte), ListaUsuarios),
    length(ListaUsuarios, CantidadUsuarios),
    CantidadUsuarios.
    %Acá tengo que poner que esa cantidad de usuarios es mayor a la del resto de los transportes.

% -------
% Punto 7
% -------

% La INVERSIBILIDAD es útil a la hora de hacer posible que existan resultados para
% consultas tanto individuales como existenciales. Es decir, que se adapte mejor al
% usuario, que sea más flexible. Para esto se debe conectar todas las variables que
% se usean, para lo cual se puede utilizar un predicado generador.

% ORDEN SUPERIOR se utiliza cuando el argumento de un predicado, es otro predicado.
% Por ejemplo, el predicado not/1 puede recibir como argumento a otro predicado ("p2"), lo
% cual permite obtener el resultado invertido de lo que "p2" nos devuelve.