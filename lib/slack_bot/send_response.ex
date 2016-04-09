defmodule SlackBot.SendResponse do

  def send({:response, text }) do
    IO.puts("Sending response: #{text}")
    SlackBot.Socket.send_message(text)
  end

  def send({:ignore}) do
  end
end
