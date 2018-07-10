defmodule TextClient.Interact do
  def start() do
    Tictactoe.Game.new_game()
    |> Player.play()
  end
end
