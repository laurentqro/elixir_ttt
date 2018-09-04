defmodule Web.Game.Store do
  @path "../../storage/"

  def get_game(name) do
    {:ok, game} = File.read(game_path(name))
    game |> Poison.Parser.parse!(%{keys: :atoms!})
  end

  def save_game(game, name) do
    game_path(name)
    |> File.write!(game |> Poison.encode!)
    game
  end

  defp game_path(name) do
    @path <> name |> Path.expand(__DIR__)
  end

  def create_storage_folder do
    File.mkdir @path
  end
end
