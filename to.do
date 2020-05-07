(write a prefilter '$VAR'('Variable') before querying pengines so
 that we known which var is which)

(IMPORTANT: write interface on Prolog side which fans out the
 variables and other structures that would otherwise be lost in
 translation)

(IMPORTANT: test whether 'A' vs A can be fixed and see if '1' vs
 1 is a problem)

(https://www.swi-prolog.org/pldoc/doc_for?object=pengines%3Aevent_to_json/4)

(do stress test of our Prolog -> Interlingua conversion to see
 how fast it is and what it depends on, to see if we can do the
 pengines or if we need to use the HTTP/UDP+JSON)

(2020-01-07 19:25:37 <aindilis> hey folks, I am currently using YASWI to
      communicate with SWIPL from Perl.  I run a findall query to grab all
      results, but it usually takes at least a second per query.  I was
      wondering about writing a Pengines client in Perl?  Any particular
      advice regarding this?
2020-01-07 19:25:40 *** oni-on-ion (~oni-on-io@2001:1970:57e0:4100::e513) has
      quit: Ping timeout: 248 seconds
2020-01-07 19:27:02 <aindilis> Oh, I should note I already have code for
      parsing Prolog from Perl into an Interlingua e.g. a(b([c,d],E)) would be
      ['a',['b',['_prolog_list','c','d'],\*{'?E'}]]
2020-01-07 19:28:21 <aindilis> Regarding Pengines client in Perl - is there
      anything SWIPL side that would prevent this?  I imagine it's just an
      HTTP-based protocol.
2020-01-07 19:31:33 <aindilis> Another Pengines-based question I have is, I
      have N SWIPL processes, and I want them to be able to query them.
      Currently I'm using SWIPL-(YASWI)->Perl->UniLang->Perl-(YASWI)->SWIPL.
      Does Pengines have a facilitator system for a hub-spoke model or would
      it be better to connect all the pengines to each other, I cannot imagine
      the latter is preferred. 
2020-01-07 19:32:13 <aindilis> And if no facilitator exists, would there be
      interest in me developing one.)
