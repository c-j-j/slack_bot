defmodule SlackBot.Slack do
  def rtm_start do
    rtm_start_response = HTTPoison.get!("https://slack.com/api/rtm.start?token=xoxb-24448692518-NsX1AFSaMqYBqg5Z6nQjBBfk")
    Poison.Parser.parse!(rtm_start_response.body)
  end
end
