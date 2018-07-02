defmodule TictactoeTest do
  use ExUnit.Case

  alias Tictactoe.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.current_player == "X"
    assert game.game_state == :playing
    assert game.board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end
