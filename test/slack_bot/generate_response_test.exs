defmodule SlackBot.GenerateResponseTest do
  use ExUnit.Case
  test 'generates a response' do
    output_message = generate_response_for(channel: 'SenderChannel')

    assert output_message["channel"] == "SenderChannel"
    assert output_message["type"] == "message"
  end

  test 'says hello back' do
    output_message = generate_response_for(text: "Hello")

    assert output_message["text"] == "Hello There"
  end

  test 'says goodbye back' do
    output_message = generate_response_for(text: "Bye")

    assert output_message["text"] == "Goodbye"
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

  def generate_response_for(input) do
    message = struct(SlackBot.Message, input)
    response = SlackBot.GenerateResponse.generate({:message, message})
    Poison.Parser.parse!(elem(response, 1))
  end
end
