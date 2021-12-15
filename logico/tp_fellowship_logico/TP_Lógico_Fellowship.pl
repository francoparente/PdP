%____BASE DE CONOCIMIENTO____

%materia(Materia, HorasCursada)

% 1er año
materia(analisisMatematicoI, 160).
materia(algebraYGAnalitica, 160).
materia(matematicaDiscreta, 96).
materia(sistemasYOrganizaciones, 96).
materia(algoritmosYEstructurasDeDatos, 160).
materia(arquitecturaDeComputadores, 128).
materia(ingenieriaYSociedad, 64).
materia(quimica, 96).

% 2do año
materia(fisicaI, 160).
materia(analisisMatematicoII, 160).
materia(probabilidadYEstadistica, 96).
materia(analisisDeSistemas, 192).
materia(sintaxisYSemanticaDeLosLenguajes, 128).
materia(paradigmasDeProgramacion, 128).
materia(inglesI, 64).
materia(sistemasDeRepresentacion, 96).

% 3er año
materia(sistemasOperativos, 128).
materia(disenioDeSistemas, 192).
materia(fisicaII, 160).
materia(matematicaSuperior, 128).
materia(gestionDeDatos, 128).
materia(legislacion, 64).
materia(economia, 96).
materia(inglesII, 64).

% 4to año
materia(redesDeInformacion, 128).
materia(administracionDeRecursos, 192).
materia(investigacionOperativa, 160).
materia(simulacion, 128).
materia(ingenieriaDeSoftware, 96).
materia(teoriaDeControl, 96).
materia(comunicaciones, 128).

% 5to año
materia(proyectoFinal, 192).
materia(inteligenciaArtificial, 96).
materia(administracionGerencial, 96).
materia(sistemasDeGestion, 128).

% Tipo de materia
materiaIntegradora(sistemasYOrganizaciones).
materiaIntegradora(analisisDeSistemas).
materiaIntegradora(disenioDeSistemas).
materiaIntegradora(administracionDeRecursos).
materiaIntegradora(proyectoFinal).
materiaLibre(inglesI).
materiaLibre(inglesII).

%Correlativas
correlativa(analisisMatematicoII, analisisMatematicoI).
correlativa(analisisMatematicoII, algebraYGAnalitica).
correlativa(fisicaII, fisicaI).
correlativa(fisicaII, analisisMatematicoI).
correlativa(analisisDeSistemas, sistemasYOrganizaciones).
correlativa(analisisDeSistemas, algoritmosYEstructurasDeDatos).
correlativa(sintaxisYSemanticaDeLosLenguajes, algoritmosYEstructurasDeDatos).
correlativa(sintaxisYSemanticaDeLosLenguajes, matematicaDiscreta).
correlativa(paradigmasDeProgramacion, algoritmosYEstructurasDeDatos).
correlativa(paradigmasDeProgramacion, matematicaDiscreta).
correlativa(sistemasOperativos, algoritmosYEstructurasDeDatos).
correlativa(sistemasOperativos, arquitecturaDeComputadores).
correlativa(sistemasOperativos, matematicaDiscreta).
correlativa(probabilidadYEstadistica, analisisMatematicoI).
correlativa(probabilidadYEstadistica, algebraYGAnalitica).
correlativa(disenioDeSistemas, paradigmasDeProgramacion).
correlativa(disenioDeSistemas, analisisDeSistemas).
correlativa(comunicaciones, arquitecturaDeComputadores).
correlativa(comunicaciones, analisisMatematicoII).
correlativa(comunicaciones, fisicaII).
correlativa(matematicaSuperior, analisisMatematicoII).
correlativa(gestionDeDatos, analisisDeSistemas).
correlativa(gestionDeDatos, paradigmasDeProgramacion).
correlativa(gestionDeDatos, sintaxisYSemanticaDeLosLenguajes).
correlativa(economia, analisisDeSistemas).
correlativa(redesDeInformacion, sistemasOperativos).
correlativa(redesDeInformacion, comunicaciones).
correlativa(administracionDeRecursos, sistemasOperativos).
correlativa(administracionDeRecursos, disenioDeSistemas).
correlativa(administracionDeRecursos, economia).
correlativa(investigacionOperativa, probabilidadYEstadistica).
correlativa(investigacionOperativa, matematicaSuperior).
correlativa(simulacion, probabilidadYEstadistica).
correlativa(simulacion, matematicaSuperior).
correlativa(ingenieriaDeSoftware, probabilidadYEstadistica).
correlativa(ingenieriaDeSoftware, disenioDeSistemas).
correlativa(ingenieriaDeSoftware, gestionDeDatos).
correlativa(teoriaDeControl, quimica).
correlativa(teoriaDeControl, matematicaSuperior).
correlativa(legislacion, analisisDeSistemas).
correlativa(legislacion, ingenieriaYSociedad).
correlativa(proyectoFinal, redesDeInformacion).
correlativa(proyectoFinal, administracionDeRecursos).
correlativa(proyectoFinal, ingenieriaDeSoftware).
correlativa(proyectoFinal, legislacion).
correlativa(inteligenciaArtificial, investigacionOperativa).
correlativa(inteligenciaArtificial, simulacion).
correlativa(administracionGerencial, administracionDeRecursos).
correlativa(administracionGerencial, investigacionOperativa).
correlativa(sistemasDeGestion, administracionDeRecursos).
correlativa(sistemasDeGestion, investigacionOperativa).
correlativa(sistemasDeGestion, simulacion).


%____PARTE 1: LAS MATERIAS____

% 1 
esPesada(Materia) :- materiaIntegradora(Materia), materia(Materia,HorasCursada), HorasCursada > 100.
esPesada(Materia) :- materia(Materia,_), atom_length(Materia, CantidadLetras), CantidadLetras >25.

% No puedo usar la siguiente funcion porque los nombres de las materias no son strings, pero:
% esPesada(Materia) :- materia(Materia,_), string_length(Materia,CantidadLetras), CantidadLetras > 25.

% También puedo convertir el atomo en una lista de caracteres y luego calcular la longitud de dicha lista:
% esPesada(Materia) :- materia(Materia,_), name(Materia,ListaLetrasMateria), length(ListaLetrasMateria,CantidadLetras), CantidadLetras > 25.

% 2a 
esInicial(Materia):-esMateria(Materia), not(correlativa(Materia,_)).

esMateria(Materia):-materia(Materia,_).

% 2b
correlativaDeCorrelativa(Materia, MateriaSucesora):- correlativa(Materia, MateriaSucesora).
correlativaDeCorrelativa(Materia, MateriaSucesora):- correlativa(MateriaProgenitora, MateriaSucesora),
correlativaDeCorrelativa(Materia, MateriaProgenitora).

materiasNecesarias(Materia, MateriasSinRepetir):- esMateria(Materia), findall(Mate, (correlativaDeCorrelativa(Materia, Mate)), Materias), sacarDuplicados(Materias, MateriasSinRepetir).

sacarDuplicados([],[]).
sacarDuplicados([Cabeza | Cola], [Cabeza | Resultado]):-not(member(Cabeza,Cola)), sacarDuplicados(Cola,Resultado).
sacarDuplicados([Cabeza | Cola], Resultado) :-member(Cabeza, Cola),sacarDuplicados(Cola, Resultado).

% 2c
materiasQueHabilita(Materia, Materias):-esMateria(Materia),findall(MateriaHabilitada, correlativaDeCorrelativa(MateriaHabilitada,Materia) ,Materias).


%____PARTE 2: CURSADA____

%REQUERIMIENTOS BASE

%curso(Alumno, Materia, Modalidad, Nota)
curso(juana, paradigmasDeProgramacion, cuatrimestral(2,2014), 3).
curso(juana, paradigmasDeProgramacion, deVerano(2017,2), 9).
curso(juana,analisisMatematicoI,anual(2020),6).
curso(juana,algebraYGAnalitica,anual(2020),9).
curso(ana,fisicaI,anual(2020),9).
curso(ana,quimica,anual(2020),4).
curso(ana,analisisMatematicoI,anual(2020),9).
curso(ana, ingenieriaYSociedad,anual(2020),9).
curso(ana,sistemasYOrganizaciones,anual(2020),9).
curso(ana,arquitecturaDeComputadores,anual(2020),9).
curso(ana,algebraYGAnalitica,anual(2020),9).
curso(ana,sistemasDeRepresentacion,anual(2020),9).
curso(jazmin, fisicaI, anual(2020), 6).
curso(tarciso, paradigmasDeProgramacion, anual(2020), 9).

notaFinal(juana, analisisMatematicoI, 6).
notaFinal(jazmin, fisicaI, 4).

% a
obtenerAnio(anual(AnioAcademico), AnioAcademico).
obtenerAnio(cuatrimestral(_, AnioAcademico),AnioAcademico).
obtenerAnio(deVerano(AnioCalendario, _), AnioAcademico):- AnioAcademico is AnioCalendario - 1.

anioDeCursada(Alumno,Materia,AnioAcademico) :-curso(Alumno,Materia,Modalidad,_), obtenerAnio(Modalidad, AnioAcademico).

% b
aproboCursada(Alumno, Materia):-curso(Alumno, Materia, _, Nota), Nota >=6.
alumno(Alumno):-curso(Alumno, _, _, _).

% c
recurso(Alumno, Materia):-curso(Alumno, Materia, Modalidad1, _) , curso(Alumno, Materia, Modalidad2, _), obtenerAnio(Modalidad1, Anio1), obtenerAnio(Modalidad2, Anio2), Anio1 \= Anio2.

%Desempenio Academico
%a

desempenioCursada(anual(_), Nota, Nota).
desempenioCursada(cuatrimestral(Nro,_), Nota, Indice):- Indice is Nota - Nro.
desempenioCursada(deVerano(_, _), Nota, Nota):- Nota < 8.
desempenioCursada(deVerano(_, _), Nota, 8):- Nota >= 8.

%b

desempenio(Alumno,Materia,Desempenio):-obtenerValoraciones(Alumno,Materia,Valoraciones), sum_list(Valoraciones,Desempenio).

obtenerValoraciones(Alumno,Materia,Valoraciones):-findall(Indice,(curso(Alumno,Materia,Modalidad,Nota), desempenioCursada(Modalidad,Nota, Indice)),Valoraciones).


%____PARTE 3: PERSONAS QUE ESTUDIAN____
rindeFinal(Alumno, Materia):-curso(Alumno, Materia, _, Nota), Nota >=6, Nota < 8.
materiaAprobada(Alumno, Materia):-rindeFinal(Alumno, Materia), notaFinal(Alumno, Materia, Nota), Nota >=6.
materiaAprobada(Alumno, Materia):-curso(Alumno, Materia, _, Nota), Nota >=8.

% a
esProcrastinadora(Alumno) :- alumno(Alumno), forall(aproboCursada(Alumno, Materia), not(materiaAprobada(Alumno, Materia)) ).

% b
esFiltro(Materia):- materiasCursadas(Materia), forall(curso(_, Materia, _, Nota), Nota < 8).

% c
esTrivial(Materia):- materiasCursadas(Materia), forall(curso(_,Materia,_,Nota), Nota >= 6).
materiasCursadas(Materia):-curso(_,Materia,_,_).


%____PARTE 4: JUEGO DE CURSADAS____

% a
%leGusta(Alumno, Materia).
leGusta(franco, paradigmasDeProgramacion).
leGusta(franco, fisicaI).
leGusta(franco, sistemasOperativos).

queCursar(Alumno, Materias) :-
    leGusta(Alumno,MateriaLinda),
    esPesada(MateriaPesada),
    materiaIntegradora(MateriaIntegradora),
    sacarDuplicados([MateriaLinda,MateriaPesada,MateriaIntegradora], Materias).

% b
materiasParaCursar(Alumno, Materias):- alumno(Alumno), findall(Materia,(esMateria(Materia), puedeCursar(Alumno, Materia)), MateriasParaCursarPosibles), sacarDuplicados(MateriasParaCursarPosibles,MateriasParaCursarPosiblesSR), combinatoria(MateriasParaCursarPosiblesSR, Materias).


% c FUNCIONA
%busco todas las materias tranqui: son las materias que son materias, que la persona puede cursar y que no son filtros. luego, le armo las combinaciones
materiasTranqui(Alumno, MateriasTranquis):- alumno(Alumno), todasMateriasTranquiPosibles(Alumno,MateriasTranquisPosibles) , sacarDuplicados(MateriasTranquisPosibles,MateriasTranquisPosiblesSR), combinatoria(MateriasTranquisPosiblesSR, MateriasTranquis).

todasMateriasTranquiPosibles(Alumno,MateriasTranquisPosibles):-findall(Materia,(materiaTranqui(Materia,Alumno)),MateriasTranquisPosibles).

materiaTranqui(Materia,Alumno):-puedeCursar(Alumno,Materia), not(esFiltro(Materia)).

puedeCursar(Alumno, Materia):- esMateria(Materia), not(aproboCursada(Alumno, Materia)), materiasNecesarias(Materia,MateriasN), forall(member(MateriaN, MateriasN), aproboCursada(Alumno, MateriaN)).


combinatoria([], []).
combinatoria([Posible|Posibles], [Posible|MateriasT]):-combinatoria(Posibles,MateriasT).
combinatoria([_|Posibles], MateriasT):-combinatoria(Posibles,MateriasT).


