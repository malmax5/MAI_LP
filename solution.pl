people([kondratev, davydov, fedorov]).
professions([painter, carpenter, plumber]).

is_known(painter, carpenter).
is_known(carpenter, plumber).
is_known(fedorov, davydov) :- fail.

check_constraints(Assignment) :-
    member(kondratev-ProfK, Assignment),
    member(davydov-ProfD, Assignment),
    member(fedorov-ProfF, Assignment),

    is_known(painter, carpenter),
    is_known(carpenter, plumber),
    \+ is_known(fedorov, davydov),
    (ProfK = carpenter, member(fedorov-Plumber, Assignment)),

    ProfK \= ProfD,
    ProfK \= ProfF,
    ProfD \= ProfF.

assign_professions(Assignment) :-
    people([kondratev, davydov, fedorov]),
    professions([painter, carpenter, plumber]),
    permutation([painter, carpenter, plumber], [Prof1, Prof2, Prof3]),
    Assignment = [kondratev-Prof1, davydov-Prof2, fedorov-Prof3],
    check_constraints(Assignment).

solution(Solution) :-
    assign_professions(Solution).

pretty_print(Solution) :-
    member(kondratev-ProfK, Solution),
    member(davydov-ProfD, Solution),
    member(fedorov-ProfF, Solution),
    format('Kondratev-~w~n', [ProfK]),
    format('Davydov-~w~n', [ProfD]),
    format('Fedorov-~w~n', [ProfF]).

main :-
    solution(Solution),
    pretty_print(Solution).