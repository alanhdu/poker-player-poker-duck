require IEx;

defmodule LeanpokerElixir.Player do
  @version "1"
  def bet_request(game_state) do
    us = game_state["players"]
         |> List.to_tuple
         |> elem(game_state["in_action"])
    min_bet = game_state["current_buy_in"] - us["bet"]


    if game_state["round"] < 2 do
      0
    else
      us["stack"]
    end
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
