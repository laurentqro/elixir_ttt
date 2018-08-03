defmodule Web.Game.Registry do

  # API

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :registry)
  end

  def whereis_name(game_name) do
    GenServer.call(:registry, {:whereis_name, game_name})
  end

  def register_name(game_name, pid) do
    GenServer.call(:registry, {:register_name, game_name, pid})
  end

  def unregister_name(game_name) do
    GenServer.cast(:registry, {:unregister_name, game_name})
  end

  def send(game_name, message) do
    case whereis_name(game_name) do
      :undefined ->
        {:badarg, {game_name, message}}
      pid ->
        Kernel.send(pid, message)
        pid
    end
  end

  # SERVER

  def init(state) do
    {:ok, Map.new}
  end

  def handle_call({:whereis_name, game_name}, _from, state) do
    {:reply, Map.get(state, game_name, :undefined), state}
  end

  def handle_call({:register_name, game_name, pid}, _from, state) do
    case Map.get(state, game_name) do
      nil ->
        {:reply, :yes, Map.put(state, game_name, pid)}

      _ ->
        {:reply, :no, state}
    end
  end

  def handle_cast({:unregister_name, game_name}, state) do
    {:noreply, Map.delete(state, game_name)}
  end
end
