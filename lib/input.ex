defmodule Input do
	def listen_to_slack(callback) do
    message = RealSlack.next_message
    spawn(fn -> callback.(message) end)
    listen_to_slack(callback)
  end
end
