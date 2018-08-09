defmodule Web.Game.Server do
  use GenServer

  # API

  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: via_tuple(name))
  end

  def save_game(name) do
    GenServer.cast(via_tuple(name), {:save_game, name})
  end

  def get_game(name) do
    GenServer.call(via_tuple(name), {:get_game, name})
  end

  def make_move(name, move) do
    GenServer.cast(via_tuple(name), {:make_move, name, move})
  end

  defp via_tuple(name) do
    {:via, Web.Game.Registry, {:name, name}}
  end

  # SERVER

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:save_game, name}, _game) do
    game = Web.Game.Store.save_game(Tictactoe.new_game(:human_vs_computer), name)
    {:noreply, game}
  end

  def handle_cast({:make_move, name, move}, _game) do
    new_game_state = Web.Game.Store.get_game(name)
                     |> Tictactoe.make_move(move)
                     |> save_game(name)

    {:noreply, new_game_state}
  end

  def handle_call({:get_game, name}, _from, _game) do
    {:reply, Web.Game.Store.get_game(name), _game}
  end

  defp save_game(game, name) do
    Web.Game.Store.save_game(game, name)
    game
  end
end
