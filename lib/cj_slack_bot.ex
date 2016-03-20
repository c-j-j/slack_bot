defmodule CjSlackBot do
  def main do
    output_pid = spawn(Output, :send_to_slack, [])
    responder_pid = spawn(Responder, :handle, [output_pid])
    spawn(Input, :listen_to_slack, [responder_pid])
  end
end
