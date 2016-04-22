defmodule SlackBot.InputSocket do

  def start_link do
    slack_response = SlackBot.Slack.rtm_start
    socket = connect!(slack_response["url"])
    result = spawn_link(__MODULE__, :listen, [socket])
    {:ok, result}
  end

  def listen(socket) do
    case socket |> receive_from_slack do
      {:text, data} ->
        SlackBot.Receiver.receive({:input, data})
      {:ping, _ } ->
        socket |> send_to_slack({:pong, ""})
    end
    listen(socket)
  end

  defp receive_from_slack(socket) do
    socket |> Socket.Web.recv!
  end

  defp send_to_slack(socket, message) do
    socket |> Socket.Web.send!(message)
  end

  defp connect!(webservice_url) do
    uri = URI.parse(webservice_url)
    host = "#{uri.scheme}://#{uri.host}"
    Socket.Web.connect!(host, path: uri.path, secure: true)
  end
end
