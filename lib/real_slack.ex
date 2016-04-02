defmodule RealSlack do
  use GenServer

  def start_link do
    slack_response = Slack.rtm_start
    socket = WebSocket.connect!(slack_response["url"])
    GenServer.start_link(__MODULE__, socket, name: __MODULE__)
  end

  def next_message do
    GenServer.call(__MODULE__, :next_message, :infinity)
  end

  def send_response(text) do
    GenServer.cast(__MODULE__, {:send_message, text})
  end

  def handle_call(:next_message, _from, socket) do
    case socket |> Socket.Web.recv! do
      {:text, data} ->
        {:reply, data, socket}
      {:ping, _ } ->
        socket |> Socket.Web.send!({:pong, ""})
        handle_call(:next_message, _from, socket)
    end
  end

  def handle_cast({:send_message, text}, socket) do
    socket |> Socket.Web.send!({:text, text})
    {:noreply, socket}
  end
end
