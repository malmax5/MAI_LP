scalar_product(List1, List2, Product) :-
    scalar_product(List1, List2, 0, Product).

scalar_product([], [], Acc, Acc).

scalar_product([], _, Acc, Acc).
scalar_product(_, [], Acc, Acc).

scalar_product([H1|T1], [H2|T2], Acc, Product) :-
    NewAcc is Acc + H1 * H2,
    scalar_product(T1, T2, NewAcc, Product).