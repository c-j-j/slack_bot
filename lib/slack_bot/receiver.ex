defmodule SlackBot.Receiver do

  def start_link do
    pid = spawn_link(__MODULE__, :listen_to_slack, [])
    Process.register(pid, :receiver)
    {:ok, pid}
  end

  def receive(message) do
    send(:receiver, message)
  end

	def listen_to_slack do
    receive do
      {:input, message} -> spawn_link(fn -> SlackBot.Worker.process(message) end)
    end

    listen_to_slack()
  end
end
