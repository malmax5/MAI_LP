people([kondratev, davydov, fedorov]).
professions([painter, carpenter, plumber]).

is_known(painter, carpenter).
is_known(carpenter, plumber).
is_known(fedorov, davydov) :- fail.

check_constraints([kondratev-Prof1, davydov-Prof2, fedorov-Prof3]) :-
    (Prof2 = painter, member(kondratev-Carpenter, [kondratev-Prof1, davydov-Prof2, fedorov-Prof3])),
    (Prof1 = carpenter, member(fedorov-Plumber, [kondratev-Prof1, davydov-Prof2, fedorov-Prof3])),
    Prof3 \= Prof2.

assign_professions(Assignment) :-
    people([kondratev, davydov, fedorov]),
    professions([painter, carpenter, plumber]),
    permutation([painter, carpenter, plumber], [Prof1, Prof2, Prof3]),
    Assignment = [kondratev-Prof1, davydov-Prof2, fedorov-Prof3],
    check_constraints(Assignment).

solution(Solution) :-
    assign_professions(Solution).