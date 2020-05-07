(copy over
 /var/lib/myfrdcsa/codebases/minor/paladin/{prolog,scripts} to
 here, then whittle this down to the raw server and client code,
 so that, as close as possible, one just need to include those,
 and maybe the file containing all the ports:
 /var/lib/myfrdcsa/codebases/minor/formalog-pengines/attempts/pengines/1/ports.pl)


cd server && swipl -g 'consult(larkc_server).' &
cd client && swipl -g 'use_module(test),larkc_client:clEval(is(X,+(1,1)),Result0),print_term(Result0,[]).'


