defmodule Web.Game.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :game_supervisor)
  end

  def start_game(name) do
    Supervisor.start_child(:game_supervisor, [name])
  end

  def init(_) do
    children = [
      worker(Web.Game.Server, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
