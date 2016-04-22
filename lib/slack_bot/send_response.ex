defmodule SlackBot.SendResponse do

  def send({:response, text }) do
    SlackBot.OutputSocket.send_message(text)
  end

  def send({:ignore}) do
  end
end
