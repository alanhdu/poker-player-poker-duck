require IEx;

defmodule LeanpokerElixir.Player do
  @version "1.618"

  def bet_request(game_state) do
    [p1, p2, p3] = game_state["players"]
    us = elem({p1, p2, p3}, game_state["in_action"])
    min_bet = game_state["current_buy_in"] - us["bet"]

    [c1, c2] = us["hole_cards"]
    cards = [c1, c2] ++ game_state["community_cards"]

    bet = cond do
      c1["rank"] == c2["rank"]   -> us["stack"] / 2

      min_bet < us["stack"] / 10 -> min_bet         # small bet
      true                       -> 0
    end

    bet |> add_noise |> clip(us, min_bet)
  end

  def add_noise(bet) do
    :random.seed :os.timestamp
    bet * (0.75 + 0.5 * :random.uniform)
  end

  def clip(bet, us, min_bet) do
    bet = cond do
      bet <= 0 -> 0
      true     -> Enum.min([us["stack"], Enum.max([min_bet, bet])])
    end
    round(bet)
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
