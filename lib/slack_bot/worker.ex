defmodule SlackBot.Worker do
  def process(input) do
    input
    |> SlackBot.Transform.transform
    |> SlackBot.GenerateResponse.generate
    |> SlackBot.SendResponse.send
  end
end
