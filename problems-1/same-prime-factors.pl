% NOT OK
% Предикат, който по дад две цели числа, разпознава дали те имат едни и същи
% прости делители

% t2() gives us false, as expected but quite slowly

t1():- % should be true
  X is 2 * 2 * 3 * 5 * 11,
  Y is 2 * 3 * 5 * 5 * 5 * 11,
  samePrimeFactors(X, Y).

t2():- % should be false
  X is 2 * 2 * 3 * 5 * 7 * 11,
  Y is 2 * 3 * 5 * 5 * 5 * 11,
  samePrimeFactors(X, Y).

samePrimeFactors(N, M):-
  getPrimeFactors(N, 2, N_factors),
  getPrimeFactors(M, 2, M_factors),
  subset(N_factors, M_factors),
  subset(M_factors, N_factors).

% Usage: getPrimeFactors(N, 2, Factors).
% getPrimeFactors(N, Current, Factors) - generates in Factors the list of all of
% N's prime factors, starting from Current
getPrimeFactors(1, _, []).

getPrimeFactors(N, Current, [Current | Factors]):-
  N > 1,
  Current =< N,
  N mod Current =:= 0,
  N_div is N div Current,
  getPrimeFactors(N_div, Current, Factors).

getPrimeFactors(N, Current, Factors):-
  N > 1,
  Current =< N,
  N mod Current \= 0,
  Current_incr is Current + 1,
  getPrimeFactors(N, Current_incr, Factors).

subset([], _).
subset([X | Rest], L):-
  member(X, L),
  subset(Rest, L).

member(X, [X | _]).
member(X, [_ | Rest]):- member(X, Rest).
