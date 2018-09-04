defmodule Player.Computer do
  defstruct(mark: "O", type: "computer")

  alias Tictactoe.Game

  def pick_move(game) do
    %{ move: move, score: _score } = game
                                     |> scored_moves
                                     |> Enum.max_by(& &1.score)
    move
  end

  defp scored_moves(game) do
    game
    |> Game.available_moves
    |> Enum.map(& score_move(&1, game))
  end

  defp score_move(move, game) do
    new_game_state = game
                     |> Game.mark_board(move, game.current_player.mark)
                     |> Game.evaluate_move
                     |> Game.switch_players

    %{ move: move, score: new_game_state |> minimax }
  end

  defp minimax(game = %Game{ game_state: "won", current_player: current_player }) do
    case current_player.mark do
      "X" -> -1
      "O" ->  1 * available_moves_count(game)
    end
  end

  defp minimax(%Game{ game_state: "tie" }), do: 0

  defp minimax(game) do
    case game.current_player.mark do
      "O" ->
        best_scored_move = game |> scored_moves |> Enum.max_by(& &1.score)
        best_scored_move.score
      "X" ->
        best_scored_move = game |> scored_moves |> Enum.min_by(& &1.score)
        best_scored_move.score
    end
  end

  defp available_moves_count(game) do
    game
    |> Game.available_moves
    |> Enum.count
  end
end
