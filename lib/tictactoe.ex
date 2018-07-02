defmodule Tictactoe do
  alias Tictactoe.Game

  defdelegate new_game, to: Game
  defdelegate make_move(game, mark, position), to: Game
end
