defmodule WebTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "/play redirects to /play/:uuid" do
    conn = conn(:get, "/play")
    conn = Web.Router.call(conn, @opts)

    [location] = conn |> get_resp_header("location")
    url_structure = ~r(/play/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})

    assert conn.status == 301
    assert Regex.match?(url_structure, location)

    conn = conn(:get, location)
    conn = Web.Router.call(conn, @opts)

    assert conn.resp_body == "{\"player_x\":{\"type\":\"human\",\"mark\":\"X\"},\"player_o\":{\"type\":\"computer\",\"mark\":\"O\"},\"game_state\":\"playing\",\"current_player\":{\"type\":\"human\",\"mark\":\"X\"},\"board\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\"]}"

    "/play" <> file_name = location

    File.rm("storage/#{file_name}")
  end

  test "invalid path returns a 404" do
    conn = conn(:get, "/gibberish")
    conn = Web.Router.call(conn, @opts)

    assert conn.status == 404
  end
end
