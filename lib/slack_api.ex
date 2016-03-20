defmodule Slack do

  def rtm_start do
    rtm_start_response = HTTPoison.get!("https://slack.com/api/rtm.start?token=xoxb-24448692518-NsX1AFSaMqYBqg5Z6nQjBBfk")
    Poison.Parser.parse!(rtm_start_response.body)
  end

  def post_message do
    payload = [token: "xoxb-24448692518-NsX1AFSaMqYBqg5Z6nQjBBfk",
               channel: "D0QD7TGBH",
               as_user: "true",
               text: "Hi"]
    post_message_response = HTTPoison.post!("https://slack.com/api/chat.postMessage",
                                           {:form, payload
})
    IO.puts(inspect Poison.Parser.parse!(post_message_response.body))
  end
end
