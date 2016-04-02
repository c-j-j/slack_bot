defmodule CjSlackBot do
  use Application

  def receiver_function(input) do
    IO.puts(inspect input)
    input
    |> SlackBot.Transform.transform
    |> SlackBot.GenerateResponse.generate
    |> SlackBot.SendResponse.send
  end

  def main do
    RealSlack.start_link

    Input.listen_to_slack(&receiver_function/1)
  end

  def start(_type, _args) do
    main
  end
end
