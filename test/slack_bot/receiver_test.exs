defmodule SlackBot.ReceiverTest do
  use ExUnit.Case, async: false

  test 'processes message and sends to output queue' do
    Process.register(self(), :sender)

    input = """
    {
    "type": "message",
    "ts": "1358878749.000002",
    "user": "U023BECGF",
    "text": "Hello"
    }
                               """
    SlackBot.Receiver.start_link
    SlackBot.Receiver.receive({:input, input})
    assert_receive({:response, "{\n\"id\": 3000,\n\"type\": \"message\",\n\"channel\": \"\",\n\"text\": \"Hello There\"\n}\n"}
)
  end
end
