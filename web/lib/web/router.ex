defmodule Web.Router do
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
    conn |> send_resp(200, encoded_game |> parse_encoded_game)
  end

  get "/play/:encoded_game_state/move/:move" do
    encoded_new_game_state = encoded_game_state
                             |> parse_encoded_game
                             |> Poison.decode!(as: %Tictactoe.Game{})
                             |> Tictactoe.make_move(move |> parse_move)
                             |> Poison.encode!
                             |> Base.encode64

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

  defp parse_encoded_game(encoded_game) do
    { :ok, decoded_game } = encoded_game |> Base.decode64
    decoded_game
  end

  defp parse_move(move) do
    { move, _rem } =  move |> Integer.parse
    move
  end
end
