defmodule Tictactoe do
  alias Tictactoe.Game

  defdelegate new_game, to: Game

  def new_game(mode) do
    Game.new_game(mode)
  end

  def make_move(game, position) do
    Game.make_move(game, position, game.current_player["mark"])
  end
end
