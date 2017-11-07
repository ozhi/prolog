% OK

/**
 * A graph is a list of pairs - the connected nodes
 * [[5,4], [4, 2], [2, 4], [2, 1], [1, 3], [3, 4], [3, 5]]
*/

% hamCycle(Graph, Cycle) - generates Cycle
hamiltonCycle(Graph, [From|Way]):-
	edge(Graph, From, To),
	hamiltonWay(Graph, To, From, Way),
	noUnusedNodes(Graph, Way).

% hamWay(Graph, From, To, Way) - generates Way
hamiltonWay(_, Node, Node, [Node]).
hamiltonWay(Graph, From, To, [From|Way]):-
	edge(Graph, From, Node),
	removeNode(Graph, From, NewGraph),
	hamiltonWay(NewGraph, Node, To, Way).

% noUnusedNodes(Graph, Way) - checks if Way uses all of Graph's nodes
noUnusedNodes([], _).
noUnusedNodes([[From,To]|Graph], Way):-
	hasMember(Way, From),
	hasMember(Way, To),
	noUnusedNodes(Graph, Way).

% hasMember(List, Item) - checks if Item is one of List's members
hasMember([Item|_], Item).
hasMember([_|List], Item):-
	hasMember(List, Item).

% edge(Graph, From, To) - generates From and To
edge([[F,T]|_], F, T).
edge([_|G], F, T):-	edge(G, F ,T).

% removeNode(Graph, Node, NewGraph) - generates NewGraph
removeNode([], _, []).
removeNode([[_, N]|G], N, NewG):- removeNode(G, N, NewG).
removeNode([[N, _]|G], N, NewG):- removeNode(G, N, NewG).
removeNode([[X,Y] |G], N, [[X,Y] |NewG]):-
	not(X =:= N),
	not(Y =:= N),
	removeNode(G, N, NewG).
