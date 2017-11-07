% NOT OK

/**
 * Graph
*/

% bipartition(Graph, Result) - generates Result - a list of the two partitions of Graph's nodes
bipartition(Graph, GroupA, GroupB):-
  separateByFirstNode(Graph, GroupA1, GroupB1, RestOfGraph),
  bipartition(RestOfGraph, GroupA2, GroupB2),
  concatenate(GroupA1, GroupA2, GroupA),
  concatenate(GroupB1, GroupB2, GroupB).

separateByFirstNode([[X, Y] | RestOfGraph], [X | GroupA], [XNeighbors | GroupB]):-
  neighbors([[X, Y] | RestOfGraph], X, XNeighbors),

concatenate([], List, List).
concatenate([Item | List1], List2, [Item | Result]):-
  concatenate(List1, List2, Result).
