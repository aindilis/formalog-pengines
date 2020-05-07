:- module(test, [psyche/0]).

:- ensure_loaded(library(pengines)).
:- ensure_loaded(library(sandbox)).
:- use_module(pengine_sandbox:game_interact).

psyche :-
	larkc_client:clEval([+,1,1],Result0),
	writeln([result0,Result0]),
	larkc_client:clEval(['all-instances','PhysiologicalConditionType','BaseKB'],Result1),
	writeln([result1,Result1]),
	larkc_helper:loadNaniSearchIntoLarKC(111111),
	hasTruthValue(larkc_hold:larkc_hold(here(kitchen)),Result2),
	writeln([result2,Result2]),
	hasTruthValue(larkc_hold:larkc_hold(here(office)),Result3),
	writeln([result3,Result3]),
	larkc_client:clEval(['all-term-assertions','LD44-111111-Mt'],Result4),
	writeln([result3,Result4]).
	%% larkc_wrappers:cycQuery(['isa','?X','FRDCSACollaborator'],'POSICommunityMt',Result),
	%% time(forall(between(1,1000,X),larkc_wrappers:allInstances('FRDCSACollaborator','POSICommunityMt',Result))).
