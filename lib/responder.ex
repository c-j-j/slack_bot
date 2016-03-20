defmodule Responder do
  def handle(output_pid) do
    receive do
      {:event, response} ->
        respond(response, output_pid)
        handle(output_pid)
    end
  end

  def respond(response, output_pid) do
    if Dict.fetch!(response, "type") == "message" do
      send(output_pid, {:output, "foo"})
    end
  end
end
