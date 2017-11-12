% OK

% Да се деф на пролог двуместен предикат с арг X и Y, който по дад списък X от
% списъци генерира при преудовлетворяване в Y елементите на декартовото
% произведение на елементите на X.

% should produce +10, +11, +12, +20, ..., -22 (but as lists)
t(Result):-
  cartesianProduct([[+, -], [1, 2], [0, 1, 2]], Result).

cartesianProduct([], []).
cartesianProduct([L | Rest], [Elem | Result]):-
  getElement(L, Elem),
  cartesianProduct(Rest, Result).

% getElement(List, Element) - generates in Element each of List's elements
getElement([First | _], First).
getElement([_ | Rest], Element):-
  getElement(Rest, Element).
