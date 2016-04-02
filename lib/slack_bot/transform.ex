defmodule SlackBot.Transform do
  def transform(message) do
    parsed = Poison.Parser.parse!(message)

    if parsed["type"] == "message" do
      {
        :message,
        %SlackBot.Message{
          text: parsed["text"],
          user: parsed["user"],
          channel: parsed["channel"]}
      }
    else
      {:ignore}
    end
  end
end


