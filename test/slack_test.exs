defmodule SlackTest do
  use ExUnit.Case
  doctest Slack

  import Mock


  test "connects to web socket" do
    Slack.connect!("ws://host/path")
    assert socket_uri == "web_socket_uri"
  end
end
