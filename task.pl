an_q([Word1, Word2, Word3, '?'], X) :-
    verb_phrase([Word1, Word2, Word3], Verb, Roles),
    X =.. [Verb | Roles].

verb_phrase([AgentWord, VerbWord, ObjectWord], Verb, [agent(Agent), object(Object)]) :-
    verb(VerbWord, Verb),
    noun(AgentWord, Agent),
    noun(ObjectWord, Object).

verb_phrase(['Кто', VerbWord, ObjectWord], Verb, [agent(Y), object(Object)]) :-
    verb(VerbWord, Verb),
    noun(ObjectWord, Object).

verb_phrase(['Где', VerbWord, ObjectWord], Verb, [object(Object), loc(X)]) :-
    verb(VerbWord, Verb),
    noun(ObjectWord, Object).

verb_phrase(['Что', VerbWord, AgentWord], Verb, [agent(Agent), object(Y)]) :-
    verb(VerbWord, Verb),
    noun(AgentWord, Agent).

verb('любит', 'любить').
verb('лежат', 'лежать').

noun('Даша', 'Даша').
noun('шоколад', 'шоколад').
noun('деньги', 'деньги').