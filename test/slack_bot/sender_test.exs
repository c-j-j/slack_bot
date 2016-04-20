defmodule SlackBot.SenderTest do
  use ExUnit.Case, async: false

  import Mock

  test 'sends message to slack' do
    with_mock SlackBot.Socket, [send_message: fn(_message) -> "" end] do
      SlackBot.Sender.start_link
      SlackBot.Sender.send_message({:response, "message"})

      assert called SlackBot.Socket.send_message("message")
    end
  end

  test 'ignores message' do
    with_mock SlackBot.Socket, [send_message: fn(_message) -> "" end] do
      SlackBot.Sender.start_link
      SlackBot.Sender.send_message({:ignore, "this"})

      assert not called SlackBot.Socket.send_message("message")
    end
  end
end
