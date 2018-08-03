defmodule Web.Router do
  use Plug.Router

  plug Plug.Logger
  plug  :match
  plug  :dispatch

  get "/play" do
    uuid = UUID.uuid1
    Web.Game.Supervisor.start_game(uuid)
    Web.Game.Server.save_game(uuid)
    conn |> redirect_to("/play/#{uuid}")
  end

  get "/play/:uuid" do
    Web.Game.Supervisor.start_game(uuid)
    response_body = Web.Game.Server.get_game(uuid) |> Poison.encode!
    conn |> send_resp(200, response_body)
  end

  get "/play/:uuid/move/:move" do
    Web.Game.Server.make_move(uuid, move |> parse_move)
    response_body = Web.Game.Server.get_game(uuid) |> Poison.encode!
    conn |> send_resp(200, response_body)
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong")
  end

  defp redirect_to(conn, target, message \\ "redirecting you ...") do
    conn
    |> put_resp_header("location", target)
    |> resp(301, message)
  end

  defp parse_move(move) do
    { move, _rem } =  move |> Integer.parse
    move
  end
end
