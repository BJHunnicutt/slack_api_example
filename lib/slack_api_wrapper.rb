# require 'httparty'
# require 'channel'

class Slack_Api_Wrapper
  TOKEN = ENV["SLACK_TOKEN"]
  BASE_URL = "http://slack.com/api/"

  def self.list_channels
    url = BASE_URL + "channels.list?token=#{TOKEN}"

    response = HTTParty.get(url)  # This returns a long hash

    my_channels = []    #To get an array of
    response["channels"].each do |channel|
      id = channel["id"]
      name = channel["name"]
      my_channels << Slack_Channel.new(name, id)
    end

    return my_channels
  end

  def self.send_message(channel, msg)
    # url = BASE_URL + "chat.postMessage?token=#{TOKEN}" + "&channel=#{channel}" + "&text=#{msg}" + "&icon_emoji=:sloth:" +"&username=Me"
    # response = HTTParty.get(url)

    url = BASE_URL + "chat.postMessage?token=#{TOKEN}"

    # Not working... Maybe since we've tried too many things
    response = HTTParty.post(url,
      body:  {
      "text" => "#{msg}",
      "channel" => "#{channel}",
      "username" => "Me",
      "icon_emoji" => ":sloth:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })

  end

end
