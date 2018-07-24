defmodule Web.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Tictactoe.Client, []),
    ]

    options = [
      name: Tictactoe.
    ]
  end
end
