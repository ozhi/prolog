% NOT OK
% getChromaticNumber works but gives the correct answer a few times before we get false

% Graph is [V, E] where
%   V is a list of vertices,
%   E is a list of edges (pairs of vertices)

% Coloring is a list of [Node, Color] correspondences - exactly one for each node in a graph,
%   such that no two adjascent nodes have the same colors

t(ChromaticNumber):-
  getChromaticNumber([[a,b,c,d,e], [[a,b],[a,d],[b,c],[b,d]]], ChromaticNumber).

t2(Coloring):-
  genColoring([[a,b,c,d,e], [[a,b],[a,d],[b,c],[b,d]]], 5, Coloring).

% getChromaticNumber(Graph, Chrom) - generates the chromatic number of Graph in Chrom
getChromaticNumber(Graph, Chrom):-
  getChromaticNumberHelper(Graph, 1, Chrom).
% genColoring cn be`1

getChromaticNumberHelper(Graph, CheckedNumber, CheckedNumber):-
  genColoring(Graph, CheckedNumber, _).
getChromaticNumberHelper(Graph, CheckedNumber, Answer):-
  not(genColoring(Graph, CheckedNumber, _)),
  CheckedNumber_incr is CheckedNumber + 1,
  getChromaticNumberHelper(Graph, CheckedNumber_incr, Answer).

% getColoring(Graph, MaxColor, Coloring) generates in Coloring all colorings of Graph in colors 1,2,...,MaxColor
genColoring([V, E], MaxColor, Coloring):-
  genPotentialColoring(V, MaxColor, Coloring),
  isValidColoring(E, Coloring).

% genColoring(V, MaxColor, PotentialColoring) generates all potential colorings of the graph with vertices V in colors 1,2,...,MaxColor
genPotentialColoring([], _, []).
genPotentialColoring([Node|Vertices], MaxColor, [[Node, CurColor] | RestOfColoring]):-
  genColor(MaxColor, CurColor),
  genPotentialColoring(Vertices, MaxColor, RestOfColoring).

% genColor(MaxColor, Color) generates all colors 1,2,...,MaxColor in Color
genColor(MaxColor, MaxColor).
genColor(MaxColor, Color):-
  MaxColor >= 2,
  MaxColor_decr is MaxColor - 1,
  genColor(MaxColor_decr, Color).

% isValidColoring(Edges, Coloring) - checks if the potential Coloring is a valid one for a graph with Edges
isValidColoring([], _).
isValidColoring([[Node1, Node2] | Edges], Coloring):-
  getColor(Coloring, Node1, Color1),
  getColor(Coloring, Node2, Color2),
  not(Color1 =:= Color2),
  isValidColoring(Edges, Coloring).

% getColor(Coloring, Node, Color) - gets in Color the color of Node in the coloring Coloring
getColor([[Node, Color] | _], Node, Color).
getColor([[SomeNode, _] | Coloring], Node, Color):-
  SomeNode \= Node,
  getColor(Coloring, Node, Color).
