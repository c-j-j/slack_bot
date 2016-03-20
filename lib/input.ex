defmodule Input do
	def listen_to_slack(pid) do
    slack_response = Slack.rtm_start
    socket = WebSocket.connect!(slack_response["url"])
    WebSocket.listen(socket, pid) #try and do a callback function here
  end
end
