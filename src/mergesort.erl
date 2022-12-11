%%%-------------------------------------------------------------------
%%% @author louiscb
%%% @doc Mergesort algorithm
%%% @end
%%% Created : 11. Dec 2022 21:44
%%%-------------------------------------------------------------------
-module(mergesort).
-export([ms/1, p_ms/1]).

%% sequential version of the merge sort function ms(L) returning L sorted
ms([]) -> [];
ms([X]) -> [X];
ms(L) ->
    {L1, L2} = sep(L, length(L) div 2),
    merge(ms(L1), ms(L2)).

%% parallel version of the merge sort function p_ms(L) returning L sorted
p_ms([]) -> [].

%% merge/2 takes a list of integers and returns a sorted list of integers
merge([],[]) -> [];
merge([H1|T1],[]) -> [H1|T1];
merge([], [H2|T2]) -> [H2|T2];
merge([H1|T1], [H2|T2]) ->
    case H1 < H2 of
        true -> [H1|merge(T1, [H2|T2])];
        false -> [H2|merge([H1|T1], T2)]
    end.

%% sep(L, N) returning {L1, L2} so that L1++L2 == L and length(L1) == N. Assumes that non negative integer N is at most the length of the list L.
sep(L,0) -> {[], L};
sep([H|T], N) ->
    {L1, L2} = sep(T, N-1),
    {[H|L1], L2}.


