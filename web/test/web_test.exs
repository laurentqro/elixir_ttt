defmodule WebTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "serves a new game" do
    conn = conn(:get, "/play")
    conn = Router.call(conn, @opts)

    assert conn.resp_body == "{\"game_state\":\"playing\",\"current_player\":\"X\",\"board\":[1,2,3,4,5,6,7,8,9]}"
  end

  test "makes move" do
    payload = Poison.encode!(%{game_state: :playing, current_player: "X", board: [1,2,3,4,5,6,7,8,9], position: "1"})
    conn = conn(:post, "/play", payload)
    conn = Router.call(conn, @opts)

    assert conn.resp_body == "{\"game_state\":\"playing\",\"current_player\":\"X\",\"board\":[\"X\",2,3,4,5,6,7,8,9]}"
  end
end
