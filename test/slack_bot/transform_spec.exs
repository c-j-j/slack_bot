defmodule SlackBot.TransformTest do
  use ExUnit.Case

  test "parses a message" do
    raw_text = "{\"type\":\"message\",\"channel\":\"channel\",\"user\":\"sender\",\"text\":\"Hello\",\"ts\":\"1459508303.000003\",\"team\":\"T026MULUJ\"}"
    parsed = SlackBot.Transform.transform(raw_text)

    assert elem(parsed, 0) == :message
    message = elem(parsed, 1)
    assert message.text == "Hello"
    assert message.user == "sender"
    assert message.channel == "channel"
  end

  test "parses a non-message" do
    raw_text = "{\"type\":\"presence_change\",\"presence\":\"active\",\"user\":\"U0QD6LCF8\"}"
    parsed = SlackBot.Transform.transform(raw_text)

    assert elem(parsed, 0) == :ignore
  end
end
