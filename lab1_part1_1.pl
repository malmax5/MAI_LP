cyclic_shift_right_manual([], []).
cyclic_shift_right_manual([H|T], ShiftedList) :-
    cyclic_shift_right_manual(T, [H], ShiftedList).

cyclic_shift_right_manual([], Acc, Acc).
cyclic_shift_right_manual([H|T], Acc, ShiftedList) :-
    cyclic_shift_right_manual(T, [H|Acc], ShiftedList).