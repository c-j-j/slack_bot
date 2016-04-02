defmodule SlackBot.GenerateResponse do
  def generate({:message, message}) do
    if message.user != "U0QD6LCF8" do
      output_message = """
      {
      "id": 3000,
      "type": "message",
      "channel": "#{message.channel}",
      "text": "Hello World"
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
