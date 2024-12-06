solve(LeftStack, Solution) :-
    initial_state(LeftStack, MiddleStack, RightStack, Moves),
    bfs([state(LeftStack, MiddleStack, RightStack, Moves)], [], Solution).

initial_state(LeftStack, [], [], []).

% BFS
bfs([State|_], _, Solution) :-
    goal(State),
    state_moves(State, Moves),
    reverse(Moves, Solution),
    state_right(State, RightStack),
    write('Final Right Stack: '), write(RightStack), nl,  % Only print final right stack
    nl.  % Newline for better output format

bfs([CurrentState|Rest], Visited, Solution) :-
    \+ member(CurrentState, Visited),
    findall(Successor, successor(CurrentState, Successor), Successors),
    append(Rest, Successors, NewQueue),
    bfs(NewQueue, [CurrentState|Visited], Solution).

% Check on good answer
goal(state(Left, Middle, Right, _)) :-
    Left == [],
    Middle == [],
    alternating(Right).

% Check on the right stack
alternating([]).
alternating([_]).
alternating([X, Y|Rest]) :-
    X \= Y,
    alternating([Y|Rest]).

% States based on allowed moves
successor(State, Successor) :-
    move(State, Successor).

% Moves
move(state([Elem|LeftRest], Middle, Right, Moves), state(LeftRest, Middle, [Elem|Right], [move(left, right)|Moves])).
move(state([Elem|LeftRest], Middle, Right, Moves), state(LeftRest, [Elem|Middle], Right, [move(left, middle)|Moves])).
move(state(Left, [Elem|MiddleRest], Right, Moves), state(Left, MiddleRest, [Elem|Right], [move(middle, right)|Moves])).
move(state(Left, Middle, [Elem|RightRest], Moves), state([Elem|Left], Middle, RightRest, [move(right, left)|Moves])).

state_left(state(Left, _, _, _), Left).
state_middle(state(_, Middle, _, _), Middle).
state_right(state(_, _, Right, _), Right).
state_moves(state(_, _, _, Moves), Moves).
