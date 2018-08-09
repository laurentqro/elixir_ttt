defmodule Player.Computer do
  defstruct(mark: "O", type: "computer")

  def pick_move(game) do
    game
    |> Tictactoe.Game.available_moves
    |> Enum.random
  end
end
