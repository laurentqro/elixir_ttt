defmodule Player do
  def play(%Tictactoe.Game{ game_state: :won }) do
    IO.puts "You won!"
    exit(:normal)
  end

  def play(%Tictactoe.Game{ game_state: :lost }) do
    IO.puts "You lost"
    exit(:normal)
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> IO.inspect
    |> display_board
    |> accept_move
    |> play
  end

  defp display_board(game) do
    IO.puts "#{Enum.at(game.board, 0)} | #{Enum.at(game.board, 1)} | #{Enum.at(game.board, 2)}\n#{Enum.at(game.board, 3)} | #{Enum.at(game.board, 4)} | #{Enum.at(game.board, 5)}\n#{Enum.at(game.board, 6)} | #{Enum.at(game.board, 7)} | #{Enum.at(game.board, 8)}"
    game
  end

  defp accept_move(game) do
    IO.gets("Your move: ")
    |> check_input(game)
  end

  defp make_move(game, position) do
    Tictactoe.make_move(game, position)
  end

  defp check_input(input, game) do
    { input, _ } = input |> String.trim |> Integer.parse
    cond do
      Enum.member?(game.board, input) ->
        make_move(game, input)
      true ->
        IO.puts "Please enter a valid move (1-9)"
        accept_move(game)
    end
  end
end