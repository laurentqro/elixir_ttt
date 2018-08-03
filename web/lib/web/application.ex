defmodule Web.Application do
  use Application

  def start(_type, _args) do
    IO.puts "Running ..."

    children = [
      Plug.Adapters.Cowboy2.child_spec(scheme: :http, plug: Web.Router, options: [port: 4000])
    ]

    options = [
      name: Web.Supervisor,
      strategy: :one_for_one,
    ]

    Supervisor.start_link(children, options)
    Web.Game.Store.create_storage_folder
    Web.Game.Supervisor.start_link
    Web.Game.Registry.start_link
  end
end
