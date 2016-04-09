defmodule SlackBot.GenerateResponseTest do
  use ExUnit.Case
  test 'generates a message to send' do
    message = %SlackBot.Message{channel: 'SenderChannel'}

    response = SlackBot.GenerateResponse.generate({:message, message})


    assert elem(response, 0) == :response
    output_message = Poison.Parser.parse!(elem(response, 1))
    assert output_message["text"] == "Hello World"
    assert output_message["channel"] == "SenderChannel"
    assert output_message["type"] == "message"
  end

  test 'does not generate response for messages from itself' do
    message = %SlackBot.Message{user: "U0QD6LCF8"}

    response = SlackBot.GenerateResponse.generate({:message, message})

    assert elem(response, 0) == :ignore
  end

  test 'generates a no-output message' do
    response = SlackBot.GenerateResponse.generate({:ignore})
    assert elem(response, 0) == :ignore
  end
end
