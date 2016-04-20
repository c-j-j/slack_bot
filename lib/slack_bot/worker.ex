defmodule SlackBot.Worker do
  def process(input) do
    input
    |> SlackBot.Transform.transform
    |> SlackBot.GenerateResponse.generate
    |> SlackBot.Sender.send_message
  end
end
