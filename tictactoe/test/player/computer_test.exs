defmodule Player.ComputerTest do
  use ExUnit.Case

  alias Player.Computer

  test "goes for the win" do
    game = Tictactoe.new_game(:human_vs_computer)
           |> Tictactoe.Game.mark_board(1, "X")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players
           |> Tictactoe.Game.mark_board(3, "O")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players
           |> Tictactoe.Game.mark_board(2, "X")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players
           |> Tictactoe.Game.mark_board(9, "O")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players
           |> Tictactoe.Game.mark_board(8, "X")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players

    assert Computer.pick_move(game) == 6
  end

  test "blocks opponent from winning" do
    game = Tictactoe.new_game(:human_vs_computer)
           |> Tictactoe.Game.mark_board(1, "X")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players
           |> Tictactoe.Game.mark_board(4, "O")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players
           |> Tictactoe.Game.mark_board(2, "X")
           |> Tictactoe.Game.evaluate_move
           |> Tictactoe.Game.switch_players

    assert Computer.pick_move(game) == 3
  end
end
