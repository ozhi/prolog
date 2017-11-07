% OK

% split(L, L1, L2) - generate all ways that L can be split into L1 and L2 (L=L1+L2)
% can also be used as append split(L, L1, L2) - generates L = L1+L2
split(L, [], L).
split([A|L], [A|L1], L2):- split(L, L1, L2).

perm([], []).
perm([A|L], R):-
  perm(L, Lperm),
  split(Lperm, L1, L2),
  split(R, L1, [A|L2]).
