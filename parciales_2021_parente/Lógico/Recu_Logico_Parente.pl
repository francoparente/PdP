% PRIMER RECUPERATORIO LÓGICO - PARENTE

% juego(juego, plataforma soportada)

juego(minecraft, pc([windows,linux,mac])).
juego(minecraft, playstation(2)).
juego(minecraft, playstation(3)).
juego(superMario, xbox).
juego(superMario, xcube).
juego(saga(finalFantasy, 1), gameboy).
juego(saga(finalFantasy, 2), gameboy).
juego(saga(finalFantasy, 3), gameboy).
juego(saga(finalFantasy, 3), gameboyColor).
juego(saga(finalFantasy, 3), xbox).
juego(saga(sonic,1), genesis).
juego(saga(sonic,2), genesis).
juego(saga(sonic,3), genesis).

% usuarios(juego, plataforma, cantidad).

usuarios(minecraft,playstation(2), 40000).
usuarios(minecraft, playstation(3), 36700).
usuarios(saga(finalFantasy, 1), gameboy, 400).
usuarios(saga(finalFantasy, 2), gameboy, 220).
usuarios(superMario, xbox, 980).
usuarios(saga(finalFantasy, 3), gameboy, 70).
usuarios(saga(finalFantasy, 3), gameboyColor, 100).
usuarios(saga(sonic, 1), genesis, 500).
usuarios(saga(sonic, 2), genesis, 800).
usuarios(saga(sonic, 3), genesis, 1400).

% PUNTO 1

portatil(psp).
portatil(gameboy).
portatil(gameboyColor).

vende(nintendo, gameboy).
vende(nintendo, xcube).
vende(nintendo, xbox).

vende(apple, pc([mac])).
vende(microsoft, pc([windows])).
vende(lenovo, pc([windows,linux])).

vende(sony, playstation(_)).

hackeable(pc(_)).
hackeable(psp).
hackeable(playstation(X)) :-
    X < 3.

% PUNTO 2

incluido(A, B) :-
    forall(member(X, A), member(X, B)).

tienePlataformaQueSoporta(Empresa,Juego) :-
    vende(Empresa,Consola),
    juego(Juego,Consola).

tienePlataformaQueSoporta(Empresa,Juego) :-
    vende(Empresa,pc(SO1)),
    juego(Juego,pc(SO2)),
    incluido(SO1,SO2).

% PUNTO 3

propietario(Empresa,Juego) :-
    juego(Juego,Plataforma),
    vende(Empresa,Plataforma),
    not((vende(Empresa2,Plataforma), Empresa2 \= Empresa)).

% PUNTO 4

prefierenPortatiles(Juego) :-
    juego(Juego,Plataforma),
    not(portatil(Plataforma)),
    forall(usuarios(Juego,PlataformaPortatil,_), portatil(PlataformaPortatil)).

% PUNTO 5

nivelFanatismo(Juego,Nivel) :-
    findall(Cantidad ,usuarios(Juego,_,Cantidad), Cantidades),
    sumlist(Cantidades, NivelTotal),
    Nivel is NivelTotal / 1000.

% PUNTO 6

esPirateable(Juego) :-
    findall(Cantidad ,usuarios(Juego,_,Cantidad), Cantidades),
    sumlist(Cantidades, Total),
    Total > 5000,
    juego(Juego,Consola),
    hackeable(Consola).

% PUNTO 7

ultimoDeLaSaga(Titulo, saga(Titulo, Edicion)) :-
    juego(saga(Titulo, Edicion), _),
    forall(juego(saga(Titulo, OtraEdicion), _), OtraEdicion =< Edicion).    

% anterior(EdicionAnterior,EdicionSiguiente) :-
%     juego(saga(Titulo, EdicionAnterior),_),
%     juego(saga(Titulo, EdicionSiguiente),_),
%     EdicionAnterior \= EdicionSiguiente,
%     EdicionSiguiente > EdicionAnterior.

% Esto no sirve porque necesito el inmediatamente anterior.

% buenaSaga(saga(Titulo,Edicion)) :-
    
% Tengo que usar recursividad.