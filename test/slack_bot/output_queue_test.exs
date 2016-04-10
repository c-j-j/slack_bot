defmodule SlackBot.OutputQueueTest do
  use ExUnit.Case

  test 'messages are dequeued in order' do
    SlackBot.OutputQueue.start_link
    SlackBot.OutputQueue.enqueue("message-a")
    SlackBot.OutputQueue.enqueue("message-b")

    retrieved_message_a = SlackBot.OutputQueue.dequeue()
    retrieved_message_b = SlackBot.OutputQueue.dequeue()

    assert retrieved_message_a == "message-a"
    assert retrieved_message_b == "message-b"
  end

  test 'no messages are dequeued' do
    SlackBot.OutputQueue.start_link

    retrieved_message_a = SlackBot.OutputQueue.dequeue()
    retrieved_message_b = SlackBot.OutputQueue.dequeue()
    assert retrieved_message_a == nil
    assert retrieved_message_b == nil
  end
end
