require 'test_helper'
require 'channel' # THis is not necessary if everything is named right

class SlackChannelTest < ActionController::TestCase
  # Just to verify that Rake can pick up the test
  test 'the truth' do
    assert true
  end

  test "you must provide a name and ID for a slack channel" do
    assert_raises ArgumentError do
      Slack_Channel.new(nil, nil)
    end
    assert_raises ArgumentError do
      Slack_Channel.new("", "")
    end
    assert_raises ArgumentError do
      Slack_Channel.new("slack_api_test", "")
    end
    assert_raises ArgumentError do
      Slack_Channel.new("", "12345")
    end
    assert_raises ArgumentError do
      Slack_Channel.new("slack_api_test", nil)
    end
    assert_raises ArgumentError do
      Slack_Channel.new(nil, "12345")
    end
  end

  test "Name attribute is set correctly" do
    test_me = Slack_Channel.new("name", "id")
    assert test_me.name == "name"
  end

  test "ID attribute is set correctly" do
    test_me = Slack_Channel.new("name", "id")
    assert test_me.id == "id"
  end



end
