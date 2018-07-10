defmodule Tictactoe do
  alias Tictactoe.Game

  defdelegate new_game, to: Game

  def make_move(game, position) do
    Game.make_move(game, position, game.current_player)
  end
end
