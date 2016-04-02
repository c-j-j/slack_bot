defmodule WebSocket do
  def connect!(webservice_url) do
    uri = URI.parse(webservice_url)
    host = "#{uri.scheme}://#{uri.host}"
    Socket.Web.connect!(host, path: uri.path, secure: true)
  end

  def listen(socket, callback_function) do
    case socket |> Socket.Web.recv! do
      {:text, data} ->
        Task.start(fn -> callback_function.(data) end)
      {:ping, _ } ->
        socket |> Socket.Web.send!({:pong, ""})
    end
    listen(socket, callback_function)
  end
end
