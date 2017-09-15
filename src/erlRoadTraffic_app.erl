%%%-------------------------------------------------------------------
%%% @author Jakub Kudzia
%%% @doc
%%% erlRoadTraffic public API
%%% @end
%%%-------------------------------------------------------------------
-module(erlRoadTraffic_app).
-author("Jakub Kudzia").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    erlRoadTraffic_sup:start_link(),
    MapJson = map_loader:load(_StartArgs),
    {Nodes, Ways} = map_loader:split_to_nodes_and_ways(MapJson),
    io:format("Nodes: ~p~n", [Nodes]),
    io:format("Ways: ~p~n", [Ways]),
%%    RoadMap = model:initialize(Nodes, Ways),
    {BaseGraph, Graph, Graph2, RoadMap} = model:initialize(Nodes, Ways),
    {Nodes, Ways, BaseGraph, Graph, Graph2, RoadMap}.
%%    io:format("~n~p~nFinished", [RoadMap]).



%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
