defmodule SlackBot do
  use Application

  def start(_type, _args) do
    SlackBot.Supervisor.start_link()
  end
end
