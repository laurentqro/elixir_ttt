defmodule Tictactoe.Game do
  defstruct(
    game_state: :playing,
    current_player: "X",
    board: [0, 1, 2, 3, 4, 5, 6, 7, 8]
  )

  def new_game() do
    %Tictactoe.Game{}
  end

  def make_move(game, position, mark) do
    game
    |> mark_board(position, mark)
    |> evaluate_move
  end

 defp evaluate_move(game) do
    new_state = game |> detect_winning_row
    Map.put(game, :game_state, new_state)
  end

  defp mark_board(game, position, mark) do
    Map.put(game, :board, List.replace_at(game.board, position, mark))
  end

  defp detect_winning_row(game) do
    game.board
    |> lines
    |> Enum.any?(fn(line) -> has_win(line) end)
    |> maybe_won
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

  defp maybe_won(true), do: :won
  defp maybe_won(_),    do: :still_playing

  defp has_win([mark, mark, mark]), do: true
  defp has_win(_),                  do: false
end
