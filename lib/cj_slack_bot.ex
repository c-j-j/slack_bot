#we get something from a web socket.
#we spawn a new process with a passed in function that takes some input and produces some output?
#this means that the concurrent process returns some result that we still need to send back to slack.

#or we spawn a process that also sends to the thing back to slack.

#Slack WS Listener -> Transform -> Responder -> Output -> Slack Rest

# Listener
#  sends the message to 

# Transform can be pure
# Responder can be pure
# Output talks to SlackAPI

# listener.get_messages |> transform |> get_response |> send_to_slack

defmodule CjSlackBot do
  def receiver_function(input) do
    IO.puts("Received")
    IO.puts(inspect input)
    input
    |> SlackBot.Transform.transform
    |> SlackBot.GenerateResponse.generate
    |> SlackBot.SendResponse.send
  end

  def main do
    RealSlack.start_link

    Input.listen_to_slack(&receiver_function/1)
  end
end
