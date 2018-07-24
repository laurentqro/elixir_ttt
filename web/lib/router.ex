defmodule Router do
  use Plug.Router

  plug Plug.Logger
  plug  :match
  plug  :dispatch

  get "/play" do
    encoded_new_game = Tictactoe.new_game()
    |> Poison.encode!
    |> Base.encode64
    conn |> redirect_to("/play/#{encoded_new_game}")
  end

  get "/play/:encoded_game" do
    { :ok, game } = encoded_game |> Base.decode64
    response_body = Map.merge(game |> Poison.decode!, %{ position: "please enter a valid move" }) |> Poison.encode!
    conn |> send_resp(200, response_body)
  end

  get "/play/:encoded_game_state/move/:move" do
    { :ok, decoded_game_state } = encoded_game_state |> Base.decode64
    { move, _rem } =  Integer.parse(move)
    encoded_new_game_state = Tictactoe.make_move(decoded_game_state |> Poison.decode!(as: %Tictactoe.Game{}), move) |> Poison.encode! |> Base.encode64

    conn |> redirect_to("/play/#{encoded_new_game_state}")
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong")
  end

  defp redirect_to(conn, target, message \\ "redirecting you ...") do
    conn
    |> put_resp_header("location", target)
    |> resp(301, message)
  end
end
