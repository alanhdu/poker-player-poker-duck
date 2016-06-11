require IEx;

defmodule LeanpokerElixir.Player do
  @version "1.61"
  def bet_request(game_state) do
    [p1, p2, p3] = game_state["players"]
    us = elem({p1, p2, p3}, game_state["in_action"])
    min_bet = game_state["current_buy_in"] - us["bet"]

    {c1, c2} = us["hole_cards"] |> List.to_tuple

    half_chips = round(us["stack"] / 2)
    tenth_chips = round(us["stack"] / 100)
    cond do
      min_bet < tenth_chips    -> min_bet
      c1["rank"] == c2["rank"] -> half_chips + Enum.random 1..half_chips
      true                     -> 0
    end
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
