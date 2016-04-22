defmodule SlackBot.OutputSocket do

  def start_link do
    slack_response = SlackBot.Slack.rtm_start
    socket = connect!(slack_response["url"])
    Agent.start_link(fn -> socket end, name: __MODULE__)
  end

  def send_message(text) do
    Agent.get(__MODULE__, fn(socket) -> send_message(socket, text) end)
  end

  def send_message(socket, text) do
    socket |> send_to_slack({:text, text})
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
