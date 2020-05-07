%% formalogPenginesCall(Executable,Result) :-
%% 	term_variables(Executable,Variables),
%% 	findnsols(1,fail,Executable,Tmp),
%% 	transform_result(Executable,Result).

%% formalogPenginesCall(Executable,Result) :-
%% 	term_variables(Executable,Variables),
%% 	findnsols(1,Variables,Executable,TmpResult),
%% 	transform_result(TmpResult,Result).

%% transform_result(Input,Input).

:- module(pengines).

transform_result(Input,Output) :-
	%% write_term([input,Input],[quoted(true)]),
	(   not(nonvar(Input)) -> (with_output_to(atom(Var),system:write_term(Input,[])),Output = '$VARIABLE'(Var)) ;
	    (	number(Input) -> Output = '$NUMBER'(Input) ;
		(   is_list(Input) -> findall(SubOutput,(member(SubInput,Input),transform_result(SubInput,SubOutput)),Output) ;
		    (	(   Input =.. [P|Args] ) ->
			(   
			    findall(SubOutput,(member(SubInput,Args),transform_result(SubInput,SubOutput)),TmpOutput),
			    Output =.. [P|TmpOutput]
			) ;  
			Output = Input)))).