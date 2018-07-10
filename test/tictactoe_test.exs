defmodule TictactoeTest do
  use ExUnit.Case

  alias Tictactoe.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.current_player == "X"
    assert game.game_state == :playing
    assert game.board == [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "mark the board" do
    game = Game.new_game() |> Game.make_move(0, "X")
    assert game.board == ["X", 1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "identifies a win in a row" do
    game = Game.new_game()
           |> Game.make_move(0, "X")
           |> Game.make_move(1, "X")
           |> Game.make_move(2, "X")

    assert game.game_state == :won
  end

  test "identifies a win in a column" do
    game = Game.new_game()
           |> Game.make_move(0, "X")
           |> Game.make_move(3, "X")
           |> Game.make_move(6, "X")

    assert game.game_state == :won
  end

  test "identifies a win in primary diagonal" do
    game = Game.new_game()
           |> Game.make_move(0, "X")
           |> Game.make_move(4, "X")
           |> Game.make_move(8, "X")

    assert game.game_state == :won
  end

  test "identifies a win in secondary diagonal" do
    game = Game.new_game()
           |> Game.make_move(2, "X")
           |> Game.make_move(4, "X")
           |> Game.make_move(6, "X")

    assert game.game_state == :won
  end
end
