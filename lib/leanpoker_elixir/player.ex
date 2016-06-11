require IEx;

defmodule LeanpokerElixir.Player do
  @version "1.618"

  def bet_request(game_state) do
    [p1, p2, p3] = game_state["players"]
    us = elem({p1, p2, p3}, game_state["in_action"])
    min_bet = game_state["current_buy_in"] - us["bet"]

    cards = us["hole_cards"] ++ game_state["community_cards"]
    ranks = Enum.map cards, &(&1["rank"])

    num_cards = cards |> length

    double = (ranks |> Enum.uniq |> length) == num_cards - 1
    better = (ranks |> Enum.uniq |> length) <= num_cards - 2

    bet = cond do
      double && (length(cards) < 3) -> 0.75 * us["stack"]
      better                        -> 0.95 * us["stack"]
      double                        -> 0.25 * us["stack"]

      min_bet < us["stack"] / 10   -> min_bet         # small bet
      true                         -> 0
    end

    bet |> add_noise |> clip(us, min_bet)
  end

  def add_noise(bet) do
    :random.seed :os.timestamp
    bet * (0.95 + 0.1 * :random.uniform)
  end

  def clip(bet, us, min_bet) do
    bet = cond do
      bet <= 0            -> 0
      bet <= min_bet - 50 -> 0
      true                -> Enum.min([us["stack"], Enum.max([min_bet, bet])])
    end
    round(bet)
  end

  def showdown(game_state) do
    "ok"
  end

  def version, do: @version
end
