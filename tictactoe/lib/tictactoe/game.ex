defmodule Tictactoe.Game do
  alias Tictactoe.Game

  defstruct(
    game_state: "playing",
    current_player: nil,
    board: [1, 2, 3, 4, 5, 6, 7, 8, 9],
    player_x: nil,
    player_o: nil
  )

  def new_game do
    %Game{} |> setup_players(:human_vs_human)
  end

  def new_game(mode) do
    %Game{} |> setup_players(mode)
  end

  def make_move(game, player = %Player.Computer{}) do
    position = Player.Computer.pick_move(game)
    game |> mark_board(position, player.mark)
  end

  def make_move(game, position, player = %Player.Human{}) do
    game |> mark_board(position, player.mark)
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
    |> lines
    |> Enum.all?(fn(line) -> !has_win(line) && is_full(line) end)
    |> maybe_tie(game)
  end

  defp is_full(line) do
    line
    |> Enum.all?(fn(cell) -> cell == "X" || cell == "O" end)
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

  defp maybe_tie(true, game) do
    Map.put(game, :game_state, "tie")
  end

  defp maybe_tie(_, game), do: game

  defp has_win([mark, mark, mark]), do: true
  defp has_win(_),                  do: false

  defp switch_players(game = %Game{ game_state: "playing" }) do
    %{ game | current_player: next_player(game) }
  end

  defp switch_players(game) do
    game
  end

  defp next_player(game) do
    case game.current_player do
      %Player.Human{mark: "X"} -> %Player.Human{mark: "O"}
      %Player.Human{mark: "O"} -> %Player.Human{mark: "X"}
    end
  end

  defp setup_players(game, :human_vs_human) do
    %{ game |
      player_x: %Player.Human{ mark: "X"},
      player_o: %Player.Human{ mark: "O"},
      current_player: %Player.Human{ mark: "X" }
    }
  end
end
