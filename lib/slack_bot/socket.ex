defmodule SlackBot.Socket do

  def start_link do
    slack_response = SlackBot.Slack.rtm_start
    socket = connect!(slack_response["url"])
    Agent.start_link(fn -> socket end, name: __MODULE__)
  end

  def next_message do
    Agent.get(__MODULE__, &(&1)) |> next_message
  end

  def send_message(text) do
    Agent.get(__MODULE__, fn(socket) -> send_message(socket, text) end)
  end

  defp next_message(socket) do
    case socket |> receive_from_slack do
      {:text, data} ->
        data
      {:ping, _ } ->
        socket |> send_to_slack({:pong, ""})
        next_message(socket)
    end
  end

  defp send_message(socket, text) do
    socket |> send_to_slack({:text, text})
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
