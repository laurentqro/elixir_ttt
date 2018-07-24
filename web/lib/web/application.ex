defmodule Web.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    IO.puts "Running ..."

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Web.Router, [], [port: 4000])
    ]

    options = [
      name: Web.Supervisor,
      strategy: :one_for_one,
    ]

    Supervisor.start_link(children, options)
  end
end
