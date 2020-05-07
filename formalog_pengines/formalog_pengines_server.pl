:- consult('/var/lib/myfrdcsa/codebases/minor/formalog-pengines/client-server/server/larkc_server').

:- consult('/var/lib/myfrdcsa/codebases/minor/formalog-pengines/attempts/pengines/1/ports').

start_agent(Agent) :-
	hasPenginePort(Agent,Port),
	go(http,localhost,Port).
