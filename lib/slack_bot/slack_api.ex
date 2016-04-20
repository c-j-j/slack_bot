defmodule SlackBot.Slack do
  def rtm_start do
    token = Application.get_env(:slack_bot, :token)
    rtm_start_response = HTTPoison.get!("https://slack.com/api/rtm.start?token=#{token}")
    Poison.Parser.parse!(rtm_start_response.body)
  end
end
