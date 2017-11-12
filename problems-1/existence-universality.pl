% OK

% деф предикати p1(X), p2(X), p3(X), p4(X), такива че ако X  е списък от списъци от числа, то:
% p1(x) <=> празният списък е елемент на X
% p2(x) <=> Z съдържа елементи Y и Z, които нямат общи елементи
% p3(x) <=> X съдържа елемент Y, чиито елементи са елементи на всички елементи на X
% p4(x) <=> за всеки елемент Y на X съществува елемент Z на X, такъв че Y и Z нямат общи елементи

% Beginning of main predicates
  p1(X):- element(X, []).

  p2(X):-
    element(X, Y),
    element(X, Z),
    not(exists_common_element(Y, Z)).

  p3(X):-
    element(X, Y),
    not(exists_Z_in_X_such_that_Y_is_not_a_subset_of_Z(X, Y)).

  p4(X):-
    not(exists_Y_in_X_such_that_not_helper1(X)).
% End of main predicates

% Beginning of helper predicates

  % element(List, Elem) -
  % 1) generates in Elem each of List's elements
  % 2) checks if List has an element Elem
  element([Elem | _], Elem).
  element([_ | Rest], Elem):- element(Rest, Elem).

  exists_common_element(L1, L2):- element(L1, Elem), element(L2, Elem).

  exists_Z_in_X_such_that_Y_is_not_a_subset_of_Z(X, Y):-
    element(X, Z),
    not(is_a_subset(Y,Z)).

  is_a_subset(X, Y):- not(exists_element_in_X_not_in_Y(X, Y)).
  exists_element_in_X_not_in_Y(X, Y):- element(X, Elem), not(element(Y, Elem)).

  exists_Y_in_X_such_that_not_helper1(X):-
    element(X, Y),
    not(helper1(X, Y)).

  helper1(X, Y):-
    element(X, Z),
    not(exists_common_element(Y, Z)).
% End of helping predicates

% Beginning of tests - tests() should be true
  tests():-
    p1_t1(), p1_t2(),
    p2_t1(), p2_t2(),
    p3_t1(), p3_t2(),
    p4_t1(), p4_t2().

  p1_t1():- p1([[1, 2], [1], [], [1, 2, 3, 4]]).
  p1_t2():- not(p1([[1, 2], [1], [3,4], [1, 2, 3, 4]])).

  p2_t1():- p2([[1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6]]).
  p2_t2():- not(p2([[1, 2, 3], [1, 3, 4], [1, 4, 5], [1, 5, 6]])).

  p3_t1():- p3([[1, 2, 100], [1, 2, 200, 201], [1, 2], [1, 2, 300, 301, 302]]).
  p3_t2():- not(p3([[1, 2, 100], [1, 2, 200, 201], [1, 2, 300, 301, 302]])).

  p4_t1():- p4([[1, 2], [2, 3], [3, 4], [4, 5]]).
  p4_t2():- not(p4([[1, 2], [2, 3], [3, 4]])).
% End of tests
