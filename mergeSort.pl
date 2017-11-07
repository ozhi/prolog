% OK

% sort the following list
test(Result):-
  mergeSort([5,6,4,7,3,8,2,9,1], Result).

mergeSort([], []).
mergeSort([Item], [Item]).
mergeSort([Item1, Item2 | Rest], Result):-
  split([Item1, Item2 | Rest], L1, L2),
  mergeSort(L1, L1Sorted),
  mergeSort(L2, L2Sorted),
  merge(L1Sorted, L2Sorted, Result).

% split(List, L1, L2) - Generate L1 and L2 by splitting List in halves
split([], [], []).
split([Item], [Item], []).
split([Item1, Item2 | Rest], [Item1 | H1], [Item2 | H2]):-
  split(Rest, H1, H2).

% merge(Smalls, Bigs, Result) - generates Result
merge([], Bigs, Bigs).
merge(Smalls, [], Smalls).
merge([Item1 | Rest1], [Item2 | Rest2], [Item1 | Rest]):-
  Item1 =< Item2,
  merge(Rest1, [Item2 | Rest2], Rest).
merge([Item1 | Rest1], [Item2 | Rest2], [Item2 | Rest]):-
  Item1 > Item2,
  merge([Item1 | Rest1], Rest2, Rest).
