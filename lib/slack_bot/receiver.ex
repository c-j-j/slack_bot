defmodule SlackBot.Receiver do

  def start_link do
    Task.start_link(fn -> listen_to_slack() end)
  end

	def listen_to_slack do
    message = SlackBot.Socket.next_message()
    spawn_link(fn -> SlackBot.Worker.process(message) end)
    listen_to_slack()
  end
end
