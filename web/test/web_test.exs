defmodule WebTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "returns hello world" do
    conn = conn(:get, "/hello")
    conn = Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end
end
