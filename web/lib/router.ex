defmodule Router do
  use Plug.Router

  plug Plug.Logger
  plug  :match
  plug  :dispatch

  get "/play" do
    response_body = Tictactoe.Game.new_web_game()
    send_resp(conn, 200, response_body)
  end

  post "/play" do
    { :ok, req_body, conn } = Plug.Conn.read_body(conn, length: 1_000_000)

    decoded_body = Poison.decode!(req_body)

    resp_body = Tictactoe.make_move(fetch_game(decoded_body), fetch_position(decoded_body)) |> Poison.encode!

    conn |> send_resp(200, resp_body)
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong")
  end

  defp fetch_game(decoded_body) do
    %{ game_state:     decoded_body["game_state"],
       current_player: decoded_body["current_player"],
       board:          decoded_body["board"]
    }
  end

  defp fetch_position(decoded_body) do
    { position, _rem } =  Integer.parse(decoded_body["position"])
    position
  end
end
