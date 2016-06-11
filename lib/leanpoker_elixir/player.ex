require IEx;

defmodule LeanpokerElixir.Player do
  @version "0.0.1"
  def bet_request(game_state) do
    us = game_state["players"]
         |> List.to_tuple
         |> elem(game_state["in_action"])
    us["stack"]
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
