defmodule SlackBot.GenerateResponse do
  def generate({:message, message}) do
    output_message = """
    {
    "id": 3000,
    "type": "message",
    "channel": "#{message.channel}",
    "text": "Hello World"
    }
    """
    {:response, output_message}
  end

  def generate({:ignore}) do
    {:ignore}
  end
end
