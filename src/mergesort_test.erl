%%%-------------------------------------------------------------------
%%% @author louis
%%% @doc Testing file for mergesort module
%%%
%%% @end
%%% Created : 11. Dec 2022 22:09
%%%-------------------------------------------------------------------
-module(mergesort_test).
-author("louis").

-include_lib("eunit/include/eunit.hrl").

sequential_empty_list_test() ->
  ?assert(mergesort:ms([]) =:= []).

parallel_empty_list_test() ->
  ?assert(mergesort:pms([]) =:= []).

sequential_mergesort_real_values_test() ->
  ?assert(mergesort:ms([27.0, 82.0, 43.0, 15.0, 10.0, 38.0, 9.0, 8.0]) =:= [8.0, 9.0, 10.0, 15.0, 27.0, 38.0, 43.0, 82.0]).

concurrent_mergesort_real_values_test() ->
  ?assert(mergesort:pms([27.0, 82.0, 43.0, 15.0, 10.0, 38.0, 9.0, 8.0]) =:= [8.0, 9.0, 10.0, 15.0, 27.0, 38.0, 43.0, 82.0]).
