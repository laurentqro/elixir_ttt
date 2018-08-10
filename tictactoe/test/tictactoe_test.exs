defmodule TictactoeTest do
  use ExUnit.Case

  alias Tictactoe.Game

  test "new game returns structure" do
    game = Game.new_game

    assert game.game_state == "playing"
    assert game.current_player == %Player.Human{mark: "X"}
    assert game.board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert game.player_x == %Player.Human{mark: "X"}
    assert game.player_o == %Player.Human{mark: "O"}
  end

  test "new human vs. computer game" do
    game = Game.new_game(:human_vs_computer)

    assert game.game_state == "playing"
    assert game.current_player == %Player.Human{}
    assert game.board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert game.player_x == %Player.Human{}
    assert game.player_o == %Player.Computer{}
  end

  test "mark the board" do
    game = Game.new_game() |> Game.make_move(1, "X")
    assert game.board == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "identifies a win in a row" do
    game = Game.new_game(:human_vs_human)
           |> Game.make_move(1, "X")
           |> Game.make_move(2, "X")
           |> Game.make_move(3, "X")

    assert game.game_state == "won"
  end

  test "identifies a win in a column" do
    game = Game.new_game()
           |> Game.make_move(1, "X")
           |> Game.make_move(4, "X")
           |> Game.make_move(7, "X")

    assert game.game_state == "won"
  end

  test "identifies a win in primary diagonal" do
    game = Game.new_game()
           |> Game.make_move(1, "X")
           |> Game.make_move(5, "X")
           |> Game.make_move(9, "X")

    assert game.game_state == "won"
  end

  test "identifies a win in secondary diagonal" do
    game = Game.new_game()
           |> Game.make_move(3, "X")
           |> Game.make_move(5, "X")
           |> Game.make_move(7, "X")

    assert game.game_state == "won"
  end

  test "identifies a tie" do
    game = Game.new_game()
           |> Game.make_move(1, "X")
           |> Game.make_move(2, "X")
           |> Game.make_move(3, "O")
           |> Game.make_move(4, "O")
           |> Game.make_move(5, "O")
           |> Game.make_move(6, "X")
           |> Game.make_move(7, "X")
           |> Game.make_move(8, "O")
           |> Game.make_move(9, "X")

    assert game.game_state == "tie"
  end

  test "switches players in :playing game" do
    game = Game.new_game() |> Game.make_move(3, "X")
    assert game.current_player == %Player.Human{mark: "O"}
  end
end
