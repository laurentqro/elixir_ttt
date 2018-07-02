defmodule Tictactoe.Game do
  defstruct(
    game_state: :playing,
    current_player: "X",
    board: [1, 2, 3, 4, 5, 6, 7, 8, 9]
  )

  def new_game() do
    %Tictactoe.Game{}
  end
end
