defmodule SlackBot.Supervisor do
  use Supervisor

  def start_link do
    result = {:ok, sup_pid} = Supervisor.start_link(__MODULE__, [])
    start_children(sup_pid)
    result
  end

  def start_children(sup_pid) do
    {:ok, _pid_slack} = Supervisor.start_child(sup_pid, worker(SlackBot.Socket, []))
    {:ok, _pid_input} = Supervisor.start_child(sup_pid, worker(SlackBot.Receiver, []))
  end

  def init(_) do
    supervise([], strategy: :one_for_all)
  end
end
