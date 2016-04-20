defmodule SlackBot.Sender do
  def start_link do
    pid = spawn_link(__MODULE__, :send_outgoing_messages, [])
    Process.register(pid, :sender)
    {:ok, pid}
  end

  def send_message(message) do
    send(:sender, message)
  end

  def send_outgoing_messages do
    receive do
      {:response, message} -> SlackBot.Socket.send_message(message)
    end

    send_outgoing_messages()
  end
end
