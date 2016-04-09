defmodule SlackBot.Input do

  def start_link(callback) do
    Task.start_link(fn -> listen_to_slack(callback) end)
  end

	def listen_to_slack(callback) do
    message = SlackBot.Socket.next_message
    spawn_link(fn -> callback.(message) end)
    listen_to_slack(callback)
  end
end
