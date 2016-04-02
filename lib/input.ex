defmodule Input do
	def listen_to_slack(callback) do
    message = RealSlack.next_message
    callback.(message)
    listen_to_slack(callback)
  end
end
