defmodule Output do
	def send_to_slack do
    receive do
      {:output, _} -> Slack.post_message
      send_to_slack
    end
  end
end
