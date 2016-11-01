require 'test_helper'
# require 'slack_api_wrapper'  # THis is not necessary if everything is named right
# require 'channel'

class SlackApiWrapperTest < ActionController::TestCase
  # Just to verify that Rake can pick up the test
  test 'the truth' do
    assert true
  end

  test "Can retreive a list of channels" do
    VCR.use_cassette("channels") do
      channels = SlackApiWrapper.listchannels
      assert channels.is_a? Array
      assert channels.length > 0
      assert_not_empty(channels)

      channels.each do | ch |
        assert ch.is_a? Slack_Channel
      end
    end
  end

  test "Retreives nil when the token is wrong" do
    VCR.use_cassette("bad-token") do
      channels = SlackApiWrapper.listchannels("bad-token")
      assert_equal(channels, nil)
    end
  end

  test "Can send valid message to real channel" do
    VCR.use_cassette("send-msg") do
      message = ":sloth:"
      response = SlackApiWrapper.sendmsg("test-api-parens", message)  # this would also work with the channel being it's ID: "C2V4F5W1Y"
      assert response["ok"]
      assert_equal(response["message"]["text"], message)
      assert_equal(response["message"]["subtype"], "bot_message")
      assert_equal(response["channel"], "C2V4F5W1Y")
    end
  end

  test "Can't send message to fake channel" do
    VCR.use_cassette("channels") do
      response = SlackApiWrapper.sendmsg("channel-doen't-exist", "test message")
      assert_not response["ok"]
      assert_not_nil response["error"]
    end
  end

  test "Can't send a bad message" do
    VCR.use_cassette("channels") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "")
      assert_not response["ok"]
      assert_not_nil response["error"]

      response = SlackApiWrapper.sendmsg("test-api-parens", nil)
      assert_not response["ok"]
      assert_not_nil response["error"]
    end
  end

  test "Can't send message to bad token" do
    VCR.use_cassette("bad-token") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "Failed message", "12345")
      assert_not response["ok"]
      assert_equal(response["error"], "invalid_auth")

      response = SlackApiWrapper.sendmsg("test-api-parens", "Failed message", "")
      assert_not response["ok"]
      assert_equal(response["error"], "not_authed")
    end
  end

end
