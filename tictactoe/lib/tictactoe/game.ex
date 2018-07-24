defmodule Tictactoe.Game do
  defstruct(
    game_state: "playing",
    current_player: "X",
    board: [1, 2, 3, 4, 5, 6, 7, 8, 9]
  )

  def new_game() do
    %Tictactoe.Game{}
  end

  def make_move(game, position, mark) do
    game
    |> mark_board(position, mark)
    |> evaluate_move
    |> switch_players
  end

  defp evaluate_move(game) do
    game
    |> detect_winning_line
    |> detect_tie
  end

  defp mark_board(game, position, mark) do
    Map.put(game, :board, List.replace_at(game.board, position - 1, mark))
  end

  defp detect_winning_line(game) do
    game.board
    |> lines
    |> Enum.any?(fn(line) -> has_win(line) end)
    |> maybe_won(game)
  end

  defp detect_tie(game) do
    game.board
    |> Enum.all?(fn(cell) -> cell == "X" || cell == "O" end)
    |> maybe_tie(game)
  end

  defp lines(board) do
    rows(board) ++ columns(board) ++ diagonals(board)
  end

  defp rows(board) do
    board |> Enum.chunk(3)
  end

  defp columns(board) do
    board
    |> rows
    |>  Matrix.transpose
  end

  defp diagonals(board) do
    [left_diagonal(board)] ++ [right_diagonal(board)]
  end

  defp left_diagonal(board) do
    board
    |> rows
    |> Enum.with_index
    |> Enum.map(fn({row, index}) -> Enum.at(row, index) end)
  end

  defp right_diagonal(board) do
    board
    |> rows
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(fn({row, index}) -> Enum.at(row, index) end)
  end

  defp maybe_won(true, game) do
    Map.put(game, :game_state, "won")
  end

  defp maybe_won(_, game), do: game

  defp maybe_tie(true) do
    Map.put(game, :game_state, "tie")
  end

  defp maybe_tie(_, game), do: game

  defp has_win([mark, mark, mark]), do: true
  defp has_win(_),                  do: false

  defp switch_players(game = %Tictactoe.Game{ game_state: "playing" }) do
    Map.put(game, :current_player, next_player(game))
  end

  defp switch_players(game) do
    game
  end

  defp next_player(%Tictactoe.Game{ current_player: "X" }) do
    "O"
  end

  defp next_player(%Tictactoe.Game{ current_player: "O" }) do
    "X"
  end
end
