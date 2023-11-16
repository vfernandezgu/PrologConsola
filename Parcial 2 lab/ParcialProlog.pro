%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
%  ESTRUCTURAS DEL LENGUAJE
%  Elaborado por: MSc. Jimena Adriana Timaná Peña %
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Hechos y reglas para hollywood
% Directores y películas
director(jj_abrams, star_trek).
director(guillermo_del_toro, hellboy).
director(gabriele_muccino, siete_almas).
director(michael_bay, transformers).
director(jon_favreau, iron_man).

% Actores y películas
actor(daniel_radcliffe, harry_potter).
actor(tom_hanks, angeles_y_demonios).
actor(megan_fox, transformers).
actor(brad_pitt, benjamin_button).
actor(downey_jr, iron_man).
actor(will_smith, siete_almas).

% Género de las películas
genero(harry_potter, aventura).
genero(star_trek, ciencia_ficcion).
genero(angeles_y_demonios, suspenso).
genero(transformers, accion).
genero(benjamin_button, drama).
genero(siete_almas, drama).
genero(iron_man, ciencia_ficcion).
genero(hellboy, ciencia_ficcion).

%Reglas

%director
directorP(Director):-director(Director,Pelicula).

% Determinar el actor y el género de la misma pelicula, conociendo el director y la película.
actor_pelicula(Director, Pelicula, Actor, Genero):- director(Director, Pelicula),actor(Actor, Pelicula),genero(Pelicula, Genero).

%Determinar la pelicula, el genero y el actor, conociendo el director
pelicula_genero_actor(Director,Pelicula,Genero,Actor):- director(Director, Pelicula),actor(Actor, Pelicula),genero(Pelicula, Genero).

%Mostrar toda la información correspondiente al director, la película que dirigió, el género y el actor participante en la misma, esto para toda la base del conocimiento almacenada.
mostrar_director_pelicula_genero_actor(Director, Pelicula, Genero, Actor,Linea1,Linea2,Linea3,Linea4):- director(Director, Pelicula),actor(Actor, Pelicula),genero(Pelicula, Genero),Linea1 :=Linea1 + 90,Linea2 :=Linea2 + 90,Linea3 :=Linea3 + 90,Linea4 :=Linea4 + 90.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ejercicio buscar elemento
%función básica:
buscar(X,[X|Cola]).

%función recursiva:
buscar(X,[Cabeza|Cola]):- buscar(X,Cola).

% Función basica para borrar un elemento de una lista
borrar(_, [], []).

% Función recursiva para eliminar un elemento de la lista
borrar(Elemento, [Elemento|Resto], ListaResultante) :- borrar(Elemento, Resto, ListaResultante).

borrar(Elemento, [Primero|Resto], [Primero|NuevaLista]) :- Elemento \= Primero,borrar(Elemento, Resto, NuevaLista).

% Función basica para concatenar dos listas
concatenar([], Lista, Lista).

% Función recursiva para concatenar dos listas
concatenar([X|Resto1], Lista2, [X|Resto3]) :- concatenar(Resto1, Lista2, Resto3).

% Función base para contar los múltiplos de 5 y no de 3
cont_multiplos([], 0, []).

% Función recursiva para contar los múltiplos de 5 y no de 3
cont_multiplos([H|T], Contador, Multiplos):- (H mod 5 =:= 0, H mod 3 =\= 0) ->
        (cont_multiplos(T, ContadorRestante, MultiplosRestantes),
         Contador is ContadorRestante + 1,
         Multiplos = [H | MultiplosRestantes]);
        cont_multiplos(T, Contador, Multiplos).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------

?-window(_, _,crea_ventana(),"Aplicación",150, 50, 450, 450), 
  window_brush(_, "SKY.bmp"),update_window(_).

%crea el menú

crea_ventana(init):- 
menu(pop_up, _,_,archivo(_),"&ARCHIVO"), 
menu(pop_up, _,_,listas(_),"&LISTAS"),
menu(pop_up, _,_,logico(_),"&LÓGICO").

%Crea submenú Archivo

archivo(init):-
menu(normal, _,_,informacion(_),"&INFORMACION"),
menu(normal, _,_,cerrar_ven(_),"&Salir").
cerrar_ven(press):- close_window(X).

%Crea submenú informacion

informacion(press):-
%esta es una etiqueta
text_out(50,100,"Autores: Juan Camilo Rodallega Mera "),
text_out(90,120,"y Valentina Fernandez Guerrero").


%Crea el Submenú listas
listas(init):-	
menu(normal, _,_,borrar_elem(_),"&Borrar Elemento"),
menu(normal, _,_,concatenar_inversa(_),"&Concatenar Inversa"),
menu(normal, _,_,conocer_multiplos(_),"&Conocer Multiplos").

% subfuncion para borrar elemento en la lista

borrar_elem(press):-  
    window( _, _, ventana_eliminar(_), "Borrar elemento en Lista", 150,50,450,450).

ventana_eliminar(init):- window_brush(_, rgb(173, 216, 230)),
    button(_,_,boton_iniciar1(_),"&Iniciar",320,35,95,30).

boton_iniciar1(press):-
    % Solicita al usuario la lista y el elemento a borrar
    read(Lista, "Ingrese la lista:"),
    read(Elemento, "Ingrese el elemento a borrar:"),
    % Implementa la lógica para eliminar el elemento de la lista
    borrar(Elemento, Lista, ListaResultante),

    (ListaResultante = Lista ->
        message("Información", "El elemento no se encuentra en la lista", s);
        message("Información", "Elemento borrado de la lista", i),
        % Muestra la lista original y la lista resultante
        text_out(50, 140, "Lista original:"),
        text_out(200, 140, print(Lista)),
        text_out(50, 160, "Elemento borrado:"),
        text_out(200, 160, print(Elemento)),
        text_out(50, 180, "Lista resultante:"),
        text_out(200, 180, print(ListaResultante))
    ).

% subfuncion para concatenar listas en orden inverso.

concatenar_inversa(press):-  
    window( _, _, ventana_concatenar_inversa(_), "Concatenar listas en orden inverso", 150,50,450,450).

ventana_concatenar_inversa(init):- window_brush(_, rgb(245, 245, 220)),
    button(_,_,boton_iniciar2(_),"&Iniciar",320,35,95,30).

boton_iniciar2(press):-
    % Solicita al usuario las dos listas
    read(Lista1, "Ingrese la primera lista:"),
    read(Lista2, "Ingrese la segunda lista:"),
    
    % Concatena las listas invertidas
    concatenar(Lista2, Lista1, ListaConcatenada),
    
    % Muestra las listas originales y la lista concatenada
    text_out(50, 140, "Primera lista:"),
    text_out(250, 140, print(Lista1)),
    text_out(50, 160, "Segunda lista:"),
    text_out(250, 160, print(Lista2)),
    text_out(50, 180, "Lista resultante:"),
    text_out(250, 180, print(ListaConcatenada)).

% subfuncion para conocer multiplos

conocer_multiplos(press):-  
    window( _, _, ventana_conocer_multiplos(_), "Concatenar listas en orden inverso", 150,50,450,450).

ventana_conocer_multiplos(init):- window_brush(_, rgb(166, 129, 182)),
    button(_,_,boton_iniciar3(_),"&Iniciar",320,35,95,30).

boton_iniciar3(press):-
    	% Solicita al usuario una lista
	read(Lista, "Ingrese la lista:"),
	% contar los múltiplos de 5 y no de 3
    	cont_multiplos(Lista, Contador, Multiplos),
	% Muestra la lista ingresada, la cantidad de múltiplos y los números que cumplen la condición
    	text_out(50, 140, "Lista ingresada:"),
    	text_out(220, 140, print(Lista)),
    	text_out(50, 160, "Cantidad de múltiplos"),
	text_out(50, 180, "de 5 y no de 3:"),
    	text_out(220, 180, print(Contador)),
    	text_out(50, 200, "Números que cumplen"),
	text_out(50, 220, "con la condición:"),
    	text_out(220, 220, print(Multiplos)).

%--------------------------------------------
%crear el submenú lógico
logico(init):-
menu(pop_up, _,_,hollywood(_),"&Hollywood").

%crea submenu hollywood
hollywood(init):-
menu(normal, _,_,primerah(_),"&Primera Pregunta"), 
menu(normal, _,_,segundah(_),"&Segunda Pregunta"),
menu(normal, _,_,tercerah(_),"&Tercera Pregunta").

%crear la subfución para determinar actor y genero,
%conociendo el director y la pelicula

primerah(press):-  
window( _, _, ventana_primerah(_), "Conocer el genero y actor de la pelicula", 150,50,450,450).

ventana_primerah(init):- window_brush(_, rgb(245, 245, 220)),button(_,_,boton_iniciarH1(_),"&Iniciar",320,35,95,30).

boton_iniciarH1(press):-
	text_out(50,80,"Determinar el actor y el género de la misma pelicula,"),
	text_out(50,100,"conociendo el director y la película"),
	read(Director,"Ingrese el director"),
	read(Pelicula,"Ingrese el la pelicula"),
	(director(Director, Pelicula) ->
        actor_pelicula(Director, Pelicula, Actor, Genero),
        text_out(50, 140, print(Director)),
        text_out(50, 160, "dirigió la película"),
        text_out(200, 160, print(Pelicula)),
        text_out(50, 180, "con el actor"),
        text_out(200, 180, print(Actor)),
        text_out(50, 200, "en el género"),
        text_out(200, 200, print(Genero)),
        clear_area(50, 140, 400, 140);
       message("Información", "No se encontraron coincidencias para el director o la película.", s)
    ).	
	

%crear la subfución para determinar pelicula, actor y genero,
%conociendo el director de la pelicula

segundah(press):-  
window( _, _, ventana_segundah(_), "Conocer la pelicula, el genero y el actor", 150,50,450,450).

ventana_segundah(init):- window_brush(_, rgb(245, 245, 220)),button(_,_,boton_iniciarH2(_),"&Iniciar",320,35,95,30).

boton_iniciarH2(press):-
	text_out(50,80,"Determinar pelicula, genero y actor,"),
	text_out(50,100,"de la misma conociendo al director"),
	read(Director,"Ingrese el director"),
	(directorP(Director)->
		pelicula_genero_actor(Director, Pelicula, Genero, Actor),
		text_out(50,140,print(Director)),
		text_out(50,160,"dirigio la pelicula"),
		text_out(200,160,print(Pelicula)),
		text_out(50,180,"con el actor"),
		text_out(200,180,print(Actor)),
		text_out(50,200,"en el genero"),
		text_out(200,200,print(Genero)),
		clear_area(50, 140, 400, 140);
	message("Información", "No se encontraron coincidencias para el director.", s)
	).

%crear la subfución para determinar pelicula, actor y genero,
%conociendo el director de la pelicula

tercerah(press):-  
window( _, _, ventana_tercerah(_), "Información del director, pelicula, actor y genero", 150,50,450,450).

ventana_tercerah(init):- window_brush(_, rgb(245, 245, 220)),button(_,_,boton_iniciarH3(_),"&Iniciar",320,35,95,30).

boton_iniciarH3(press):-
	Linea1 :=60,
	Linea2 :=80,
	Linea3 :=100,
	Linea4 :=120,
	text_out(50,80,"Mostrar el director, la pelicula,"),
	text_out(50,100,"el actor y el genero de la misma "),
	mostrar_director_pelicula_genero_actor(Director, Pelicula, Genero, Actor,Linea1,Linea2,Linea3,Linea4),
	text_out(50,Linea1,print(Director)),
	text_out(50,Linea2,"dirigio la pelicula"),
	text_out(200,Linea2,print(Pelicula)),
	text_out(50,Linea3,"con el actor"),
	text_out(200,Linea3,print(Actor)),
	text_out(50,Linea4,"en el genero"),
	text_out(200,Linea4,print(Genero)),
	clear_area(50, 140, 400, 140).