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



start()->
{
"employees": [
{ "firstName":"Bill" , "lastName":"Gates" },
{ "firstName":"George" , "lastName":"Bush" },
{ "firstName":"Thomas" , "lastName":"Carter" }
]
}"
  msgpack:pack({[{<<"key">>, <<"value">>}]}, [{format, jiffy}]),

  io:format("pack: ~ts",[Pack]),
  io:format("222222").

times(F, X,  0) -> F(X);
times(F, X, N) -> F(X), times(F, X, N-1).
