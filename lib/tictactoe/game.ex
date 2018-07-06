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
    Map.put(game, :board, List.replace_at(game.board, position, mark))
    |> evaluate_move
  end

 def evaluate_move(game) do
    new_state = game |> detect_winning_row
    Map.put(game, :game_state, new_state)
  end

  defp detect_winning_row(game) do
    game
    |> lines
    |> Enum.any?(fn(line) -> has_win(line) end)
    |> maybe_won
  end

  defp lines(game) do
    rows(game) ++ columns(game)
  end

  def rows(game) do
    Enum.chunk(game.board, 3)
  end

  def columns(game) do
    game
    |> rows
    |>  Matrix.transpose
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_),    do: :still_playing

  defp has_win([mark, mark, mark]), do: true
  defp has_win(_),                  do: false
end
