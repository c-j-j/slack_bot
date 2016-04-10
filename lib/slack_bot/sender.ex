defmodule SlackBot.Sender do
  def start_link do
   Task.start_link(fn -> execute() end)
  end

  def execute do
    next_message = SlackBot.OutputQueue.dequeue

    if next_message != nil do
      send(next_message)
    end

    throttle()
    execute()
  end

  defp throttle do
    :timer.sleep(20)
  end

  defp send(message) when message != nil do
    SlackBot.SendResponse.send(message)
  end
end
