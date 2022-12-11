%%%-------------------------------------------------------------------
%%% @author louiscb
%%% @doc Mergesort algorithm
%%% @end
%%% Created : 11. Dec 2022 21:44
%%%-------------------------------------------------------------------
-module(mergesort).
-export([ms/1, pms/1, p_ms/2]).

%% @doc Sequential mergesort
%%
%%
ms([]) -> [];
ms([X]) -> [X];
ms(L) ->
    {L1, L2} = sep(L, length_of_list(L)),
    merge(ms(L1), ms(L2)).

%% @doc Parallel mergesort
%%
%%
pms([]) -> [];
pms([X]) -> [X];
pms(L) -> Pid = spawn(mergesort, p_ms, [self(), L]),
    rcvp(Pid).

rcvp(Pid) ->
    receive
        {Pid, L} -> L
    end.

%% Parallel sort is initiated with L length > 100
p_ms(Pid, L) when length(L) < 100 -> Pid ! {self(), ms(L)};
p_ms(Pid, L) -> {L1, L2} = sep(L, length_of_list(L)),
    Pid1 = spawn(mergesort, p_ms, [self(), L]),
    Pid2 = spawn(mergesort, p_ms, [self(), L]),
    L1 = rcvp(Pid1),
    L2 = rcvp(Pid2),
    Pid ! {self(), merge(L1, L2)}.

%% @doc Common private functions
%%
%%

%% sep(L, N) returning {L1, L2} so that L1++L2 == L and length(L1) == N. Assumes that non negative integer N is at most the length of the list L.
sep(L,0) -> {[], L};
sep([H|T], N) ->
    {L1, L2} = sep(T, N-1),
    {[H|L1], L2}.

%% merge/2 takes a list of integers and returns a sorted list of integers
merge([],[]) -> [];
merge([H1|T1],[]) -> [H1|T1];
merge([], [H2|T2]) -> [H2|T2];
merge([H1|T1], [H2|T2]) ->
    case H1 < H2 of
        true -> [H1|merge(T1, [H2|T2])];
        false -> [H2|merge([H1|T1], T2)]
    end.

length_of_list(L) ->
    length(L) div 2.