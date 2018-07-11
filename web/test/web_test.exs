defmodule WebTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "/play redirects to /play/encoded_game" do
    conn = conn(:get, "/play")
    conn = Web.Router.call(conn, @opts)

    game = %{ game_state: :playing, current_player: "X", board: [1,2,3,4,5,6,7,8,9] }
    prompt = %{ position: "please enter a valid move" }

    encoded_game_state = game
                         |> Poison.encode!
                         |> Base.encode64

    [location] = conn |> get_resp_header("location")

    assert conn.status == 301
    assert location == "/play/#{encoded_game_state}"
  end

  test "/move/:move redirects to /play/new_encoded_game_state" do
    encoded_game_state = Tictactoe.new_game |> Poison.encode! |> Base.encode64

    conn = conn(:get, "/play/#{encoded_game_state}/move/1")
    conn = Web.Router.call(conn, @opts)

    encoded_new_game_state = %{ game_state: :playing, current_player: "O", board: ["X",2,3,4,5,6,7,8,9] }
                             |> Poison.encode!
                             |> Base.encode64

    [location] = conn |> get_resp_header("location")

    assert conn.status == 301
    assert location == "/play/#{encoded_new_game_state}"
  end

  test "/play/encoded_game_state displays the game state in its response body" do
    encoded_game_state = Tictactoe.new_game |> Poison.encode! |> Base.encode64

    conn = conn(:get, "/play/#{encoded_game_state}")
    conn = Web.Router.call(conn, @opts)

    assert conn.resp_body == "{\"game_state\":\"playing\",\"current_player\":\"X\",\"board\":[1,2,3,4,5,6,7,8,9]}"
  end

  test "invalid path returns a 404" do
    conn = conn(:get, "/gibberish")
    conn = Web.Router.call(conn, @opts)
    assert conn.status == 404
  end
end
