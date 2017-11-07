%OK

% sort the following list
test(Result):-
  quickSort([5,6,4,7,3,8,2,9,1], Result).

% quickSort(List, Result) - generates Result
quickSort([], []).
quickSort([Pivot | Rest], Result):-
  partition(Rest, Pivot, Smalls, Bigs),
  quickSort(Smalls, SmallsSorted),
  quickSort(Bigs, BigsSorted),
  concatenate(SmallsSorted, [Pivot | BigsSorted], Result).

% partition(List, Pivot, Smalls, Bigs) - generates Smalls and Bigs
partition([], _, [], []).
partition([Item | Rest], Pivot, [Item | OtherSmalls], Bigs):-
  Item =< Pivot,
  partition(Rest, Pivot, OtherSmalls, Bigs).
partition([Item | Rest], Pivot, Smalls, [Item | OtherBigs]):-
  Item > Pivot,
  partition(Rest, Pivot, Smalls, OtherBigs).

% conctenate(List1, List2, Result) - generates Result
concatenate([], List, List).
concatenate([Item | Rest], List, [Item | Others]):-
  concatenate(Rest, List, Others).
