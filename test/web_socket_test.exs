defmodule WebSocketTest do
  use ExUnit.Case, async: false
  doctest Slack

  import Mock

  test_with_mock "connects to web socket", Socket.Web, [connect!: fn(_url, _ops) -> "foo" end] do
    WebSocket.connect!("ws://host.com/path")
    assert called Socket.Web.connect!("ws://host.com", path: "/path", secure: true)
  end
end
