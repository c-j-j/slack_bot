defmodule WebSocket do
  def connect!(webservice_url) do
    uri = URI.parse(webservice_url)
    host = "#{uri.scheme}://#{uri.host}"
    Socket.Web.connect!(host, path: uri.path, secure: true)
  end

  def listen(socket, responder_pid) do
    case socket |> Socket.Web.recv! do
      {:text, data} ->
        IO.puts("received #{inspect data}")
        send(responder_pid, {:event, Poison.Parser.parse!(data)})
      {:ping, _ } ->
        socket |> Socket.Web.send!({:pong, ""})
    end
    listen(socket, responder_pid)
  end
end
