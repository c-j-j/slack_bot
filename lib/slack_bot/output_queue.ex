defmodule SlackBot.OutputQueue do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :output_queue)
  end

  def enqueue(message) do
    GenServer.cast(:output_queue, {:enqueue, message})
  end

  def dequeue do
    GenServer.call(:output_queue, :dequeue)
  end

  def handle_call(:dequeue, _from_pid, current_queue) do
    [next|rest] = dequeue_item(current_queue)
    {:reply, next, rest}
  end

  def handle_cast({:enqueue, message}, current_queue) do
    new_queue = List.insert_at(current_queue, -1, message)
    {:noreply, new_queue}
  end

  def retrieve do
    GenServer.call(:stash, :get)
  end

  def dequeue_item([]), do: [nil, nil]
  def dequeue_item([next|rest]) do
    [next|rest]
  end
end
