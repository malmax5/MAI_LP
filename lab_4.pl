% Define the main predicate to solve the problem
solve(LeftStack, Solution) :-
    initial_state(LeftStack, MiddleStack, RightStack, Moves),
    bfs([state(LeftStack, MiddleStack, RightStack, Moves)], [], Solution).

% Define the initial state
initial_state(LeftStack, [], [], []).

% BFS implementation
bfs([State|_], _, Solution) :-
    goal(State),
    state_right(State, RightStack),
    write('Final Right Stack: '), write(RightStack), nl,
    state_moves(State, Solution).

bfs([CurrentState|Rest], Visited, Solution) :-
    \+ member(CurrentState, Visited),
    findall(Successor, successor(CurrentState, Successor), Successors),
    append(Rest, Successors, NewQueue),
    bfs(NewQueue, [CurrentState|Visited], Solution).

% Check if the current state is the goal state
goal(state(Left, Middle, Right, _)) :-
    Left == [],
    Middle == [],
    alternating(Right).

% Check if the right stack has alternating 'b' and 'w'
alternating([]).
alternating([_]).
alternating([X, Y|Rest]) :-
    X \= Y,
    alternating([Y|Rest]).

% Define successor states based on allowed moves
successor(State, Successor) :-
    move(State, Successor),
    state_left(State, Left),
    state_middle(State, Middle),
    state_right(State, Right),
    write('Move: '), write(NewMoves), nl,
    write('Left: '), write(NewLeft), nl,
    write('Middle: '), write(NewMiddle), nl,
    write('Right: '), write(NewRight), nl, nl.

% Define possible moves
move(state([Elem|LeftRest], Middle, Right, Moves), state(LeftRest, Middle, [Elem|Right], [move(left, right)|Moves])).

move(state([Elem|LeftRest], Middle, Right, Moves), state(LeftRest, [Elem|Middle], Right, [move(left, middle)|Moves])).

move(state(Left, [Elem|MiddleRest], Right, Moves), state(Left, MiddleRest, [Elem|Right], [move(middle, right)|Moves])).

move(state(Left, Middle, [Elem|RightRest], Moves), state([Elem|Left], Middle, RightRest, [move(right, left)|Moves])).

% Helper predicates to access state components
state_left(state(Left, _, _, _), Left).
state_middle(state(_, Middle, _, _), Middle).
state_right(state(_, _, Right, _), Right).
state_moves(state(_, _, _, Moves), Moves).