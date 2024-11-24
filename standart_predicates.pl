% list_predicates.pl

% Предикат my_length/2
% Вычисляет длину списка
my_length([], 0).
my_length([_|T], N) :- my_length(T, N1), N is N1 + 1.

% Предикат my_member/2
% Проверяет, является ли элемент членом списка
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

% Предикат my_append/3
% Объединяет два списка
my_append([], L, L).
my_append([H|T], L, [H|R]) :- my_append(T, L, R).

% Предикат my_remove/3
% Удаляет первое вхождение элемента из списка
my_remove(X, [X|T], T).
my_remove(X, [H|T], [H|R]) :- X \= H, my_remove(X, T, R).

% Предикат my_permute/2
% Генерирует все перестановки списка
my_permute([], []).
my_permute(L, [H|T]) :- my_remove(H, L, R), my_permute(R, T).

% Предикат my_sublist/2
% Проверяет, является ли один список подсписком другого
my_sublist(S, L) :- my_append(_, L1, L), my_append(S, _, L1).
