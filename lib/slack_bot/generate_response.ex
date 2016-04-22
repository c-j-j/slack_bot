defmodule SlackBot.GenerateResponse do

  def generate_reply("hello") do
    'Hello There'
  end

  def generate_reply("bye") do
    'Goodbye'
  end

  def generate_reply(_) do
    possible_responses = [
      "What on earth do you want?!",
      "Do go away.",
      "Okay",
      "Sure",
      "I do not want to talk to you, okay?",
      "Thanks",
      "I don't do much, sorry.",
      "...",
      "I'm shy"
    ]

    Enum.random(possible_responses)
  end

  def generate({:message, message}) do
    if message.user != "U0QD6LCF8" do
      input = String.downcase(message.text)
      reply = generate_reply(input)

      output_message = """
      {
      "id": 3000,
      "type": "message",
      "channel": "#{message.channel}",
      "text": "#{reply}"
      }
      """
      {:response, output_message}
    else
      {:ignore}
    end
  end

  def generate({:ignore}) do
    {:ignore}
  end

end
