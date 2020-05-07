:- module(larkc_client, [
			 clEval/2,
			 larkcClCall/2
			]).

:- use_module(library(pengines)).
:- use_module(library(statistics)).
:- use_module(library(hostname)).

:- use_module(util).

larkcCall(Callable) :-
	hostname(Hostname),
	(   (	Hostname = ai ; Hostname = optimus) -> pengine_rpc('http://127.0.0.1:9880',Callable) ; pengine_rpc('http://partyserver.rocks:9880',Callable)).


clEval(SubL,Result) :-
	view([subL,SubL]),
	larkcCall(larkc_api:my_cl_eval(SubL,Result)).

larkcClCall(SubL,Result) :-
	catch( pengine_rpc('http://127.0.0.1:9886',my_cl_eval(SubL,Result)), fail, true).

query_formalog_pengines(Scheme,Host,Port,Query,Result) :-
	atomic_list_concat([Scheme,'://',Host,':',Port],'',Location),
	print_term([location,Location],[]),nl,
	catch( pengine_rpc(Location,larkc_api:my_cl_eval(Query,Result)), fail, true).
