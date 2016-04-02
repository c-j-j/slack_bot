defmodule SlackBot.SendResponse do

  def send({:response, text }) do
    IO.puts("Sending response: #{text}")
    RealSlack.send_message(text)
  end

  def send({:ignore}) do
  end
end
