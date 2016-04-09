defmodule SlackBot.Supervisor do
  use Supervisor

  def start_link do
    result = {:ok, sup_pid} = Supervisor.start_link(__MODULE__, [])
    start_children(sup_pid)
    result
  end

  def receiver_function(input) do
    input
    |> SlackBot.Transform.transform
    |> SlackBot.GenerateResponse.generate
    |> SlackBot.SendResponse.send
  end

  def start_children(sup_pid) do
    {:ok, _pid_slack} = Supervisor.start_child(sup_pid, worker(SlackBot.Socket, []))
    {:ok, _pid_input} = Supervisor.start_child(sup_pid, worker(SlackBot.Input, [&receiver_function/1]))
  end

  def init(_) do
    supervise([], strategy: :one_for_all)
  end
end
