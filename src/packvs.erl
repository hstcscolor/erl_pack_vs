%%%-------------------------------------------------------------------
%%% @author ycx
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 三月 2016 下午3:53
%%%-------------------------------------------------------------------
-module(packvs).
-author("ycx").

%% API
-export([start/0]).

-define(JSON_FILE, "proto/test.json").
-define(NUM_TESTS, 300).

start()->

  {ok, Json} = file:read_file(?JSON_FILE),
  Decode = jiffy:decode(Json),
%  erlang:apply(fun jiffy:encode/1, [Decode]),

  Result = bench(fun jiffy:encode/1, fun jiffy:decode/1, [Decode] ),
  io:format("result:~p",[Result]),


  Result2 = bench_msgpack(fun msgpack:pack/2, fun msgpack:unpack/2, [Decode] , [[{format, jiffy}]]),
  io:format("result:~p",[Result2]),
  ok.


%%  msgpack:pack({[{<<"key">>, <<"value">>}]}, [{format, jiffy}]),
%%  io:format("222222").

bench(EncFun, DecFun, Decoded ) ->
  EncThunk = fun() -> times(EncFun, Decoded, ?NUM_TESTS) end,
  {EncTime, TestJSON} = timer:tc(EncThunk),
  DecThunk = fun() -> times(DecFun, [TestJSON] , ?NUM_TESTS) end,
  {DecTime, _} = timer:tc(DecThunk),
  {EncTime, DecTime}.
bench_msgpack(EncFun, DecFun, Decoded, Param) ->
  EncThunk = fun() -> times(EncFun, Decoded ++ Param, ?NUM_TESTS) end,
  {EncTime, TestJSON} = timer:tc(EncThunk),
  DecThunk = fun() -> times(DecFun, [TestJSON] ++ Param, ?NUM_TESTS) end,
  {DecTime, _} = timer:tc(DecThunk),
  {EncTime, DecTime}.

times(F, X,  0) -> erlang:apply(F, X);
times(F, X, N) -> erlang:apply(F, X), times(F, X, N-1).
