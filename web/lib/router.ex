defmodule Router do
  use Plug.Router

  plug Plug.Logger
  plug  :match
  plug  :dispatch

  get "/play" do
    response_body = Tictactoe.Game.new_web_game()
    send_resp(conn, 200, response_body)
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong")
  end
end
