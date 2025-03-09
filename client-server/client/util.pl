:- module(util, [view/1,
		 viewIf/1,
		 html_tab/1
		]).

:- dynamic ld44Flag/1.

%% ld44Flag(debug).

view(Item) :-
	html_tab(3),write_term(Item,[quoted(true)]),nl.


viewIf(Item) :-
 	(   ld44Flag(debug) -> 
	    (	html_tab(3),write_term(Item,[quoted(true)]),nl) ;
	    true).

html_tab(N) :-
	foreach(between(1,N,_X),write('&nbsp;')).
