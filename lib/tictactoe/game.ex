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
    board = List.replace_at(game.board, position, mark)
    Map.put(game, :board, board)
  end
end
