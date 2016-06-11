require IEx;

defmodule LeanpokerElixir.Player do
  @version "1"
  def bet_request(game_state) do
    us = game_state["players"]
         |> List.to_tuple
         |> elem(game_state["in_action"])
    min_bet = game_state["current_buy_in"] - us["bet"]

    {c1, c2} = us["hole_cards"] |> List.to_tuple

    cond do
      c1["rank"] == c2["rank"] -> us["stack"]
      true                     -> 0
    end
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
