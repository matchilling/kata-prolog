% First, we start with defining the land borders of each member
% country as facts in our knowledge base. The predicate
% neighbours/2 determines the list of neighbours of a country.
neighbours(austria        , [czech_republic, germany, hungary, italy,
                             slovenia, slovakia]).
neighbours(belgium        , [france, netherlands, luxemburg, germany,
                             united_kingdom]).
neighbours(bulgaria       , [romania, greece]).
neighbours(croatia        , [slovenia, hungary]).
neighbours(cyprus         , [greece]).
neighbours(czech_republic , [germany, poland, slovakia, austria]).
neighbours(denmark        , [germany, sweden]).
neighbours(estonia        , [finland, latvia, lithuania]).
neighbours(finland        , [estonia, sweden]).
neighbours(france         , [spain, belgium, luxemburg, germany, italy,
                             united_kingdom]).
neighbours(germany        , [netherlands, belgium, luxemburg, denmark,
                             france, austria, poland, czech_republic]).
neighbours(greece         , [bulgaria, cyprus]).
neighbours(hungary        , [austria, slovakia, romania, croatia,
                             slovenia]).
neighbours(ireland        , [united_kingdom]).
neighbours(italy          , [france, austria, slovenia]).
neighbours(latvia         , [estonia, lithuania]).
neighbours(luxemburg      , [belgium, france, germany]).
neighbours(malta          , []).
neighbours(netherlands    , [belgium, germany, united_kingdom]).
neighbours(poland         , [germany, czech_republic, slovakia,
                             lithuania]).
neighbours(portugal       , [spain]).
neighbours(romania        , [hungary, bulgaria]).
neighbours(slovakia       , [czech_republic, poland, hungary, austria]).
neighbours(slovenia       , [austria, italy, hungary, croatia]).
neighbours(spain          , [france, portugal]).
neighbours(sweden         , [finland, denmark]).
neighbours(united_kingdom , [ireland, netherlands, belgium, france]).

% The predicate colour_countries/1 is our main entry-point which
%  we will later use to invoke the program. It first uses setof/3
%  to create a list of terms in the form Country/Var. It then uses
% colours/2 to bind each Var in this list to an appropriate colour.
colour_countries(Colours) :-
  setof(Country/_, X^neighbours(Country,X), Colours),
  colours(Colours).

% The predicate colours/1 just returns true if there are no elements
% in a given list.
colours([]).

% For a list of head Country/Colour and tail Rest, the predicate
% colours/2 colours all the Rest. Then selects a value for Colour
% from the list of candidates, then check that there is no country
% in Rest which neighbours the Country just coloured and had the
% same Colour.
colours([Country/Colour | Rest]):-
  colours(Rest),
  member(Colour, [green, yellow, red, purple]),
  \+ (member(CountryA/Colour, Rest), neighbour(Country, CountryA)).

% The predicate neighbour/2 determines whether or not two given
% countries are neighbours.
neighbour(Country, CountryA):-
  neighbours(Country, Neighbours),
  member(CountryA, Neighbours).

% The member/2 predicate we have used in colours/1 and neighbours/2
% is just a standard membership utility function which checks if X
% is a member of a given list.
member(X, [X|_]).
member(X, [_|Tail]):-
  member(X, Tail).

% Let us now execute the program by invoking colour_countries/1.
% ?- colour_countries(Map).
%
% Example response:
% Map = [
%   austria/yellow,
%   belgium/purple, bulgaria/yellow,
%   croatia/yellow, cyprus/yellow, czech_republic/purple,
%   denmark/yellow,
%   estonia/red,
%   finland/yellow, france/yellow,
%   germany/red, greece/green,
%   hungary/red,
%   ireland/yellow, italy/red,
%   latvia/green, luxemburg/green,
%   malta/green,
%   netherlands/yellow,
%   poland/yellow, portugal/yellow,
%   romania/green, slovakia/green, slovenia/green, spain/green, sweden/green,
%   united_kingdom/green
%   ].
