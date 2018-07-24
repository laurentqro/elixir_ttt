defmodule WebTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "serves a new game" do
    conn = conn(:get, "/play")
    conn = Router.call(conn, @opts)

    game = %{ game_state: :playing, current_player: "X", board: [1,2,3,4,5,6,7,8,9] }
    prompt = %{ position: "please enter a valid move" }

    encoded_game = game
                   |> Poison.encode!
                   |> Base.encode64

    resp_body = Map.merge(game, prompt) |> Poison.encode!

    assert conn.resp_body == resp_body
  end

  test "makes move" do
    encoded_game = Tictactoe.new_game |> Poison.encode! |> Base.encode64
    conn = conn(:get, "/play/#{encoded_game}/move/1")
    conn = Router.call(conn, @opts)

    assert conn.resp_body == "{\"game_state\":\"playing\",\"current_player\":\"O\",\"board\":[\"X\",2,3,4,5,6,7,8,9]}"
  end
end
