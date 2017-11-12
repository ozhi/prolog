% OK
% use tuple(k,X) to generate all k-tuples of natural (0,1,2,...) numbers in X

natural(0).
natural(N_incr):- natural(N), N_incr is N + 1.

% every positive natural number can be represented as N = 2^a*(2b+1) <=> [a, b]
positive_to_natural_pair(N, [A, B]):-
  N mod 2 =:= 0,
  Nhalf is N div 2,
  positive_to_natural_pair(Nhalf, [X, Y]),
  A is X + 1,
  B is Y.
positive_to_natural_pair(N, [A, B]):-
  N mod 2 =:= 1,
  A is 0,
  B is (N - 1) div 2.

natural_to_natural_tuple(N, 1, [N]).
natural_to_natural_tuple(N, K, [A| Tuple]):-
  K > 1,
  N_incr is N + 1,
  positive_to_natural_pair(N_incr, [A, B]),
  K_decr is K - 1,
  natural_to_natural_tuple(B, K_decr, Tuple).

% generates all k-tuples of natural numbers
tuple(K, Tuple):- natural(N), natural_to_natural_tuple(N, K, Tuple).
