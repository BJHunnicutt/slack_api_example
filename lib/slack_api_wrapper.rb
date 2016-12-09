<<<<<<< HEAD
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

=======

require 'httparty'

class SlackApiWrapper
  BASE_URL = "https://slack.com/api/"
  TOKEN  = ENV["TOKEN"]

  attr_reader :name, :id, :purpose, :is_archived, :members

  def initialize(name, id, options = {} )
    @name = name
    @id = id

    @purpose = options[:purpose]
    @is_archived = options[:is_archived]
    @is_general = options[:is_archived]
    @members = options[:members]
  end

  def self.sendmsg(channel, msg, token = nil)
    token = TOKEN if token == nil

    url = BASE_URL + "chat.postMessage?" + "token=#{token}"
    # puts url
    # puts "Channel = #{channel}"
    data = HTTParty.post(url,
               body:  {
                  "text" => "#{msg}",
                  "channel" => "#{channel}",
                  "username" => "CheezItBot",
                  "icon_url" => "https://avatars.slack-edge.com/2016-06-01/47243492547_e3bd80a93a62bd63b8e6_72.png",
                  "as_user" => "false"
                },
             :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
  end

  def self.listchannels(token = nil)
    token ||= TOKEN
    url = BASE_URL + "channels.list?" + "token=#{token}" + "&pretty=1&exclude_archived=1"
    data = HTTParty.get(url)
    channels = []
    if data["channels"]  # if the request was successful
      data["channels"].each do |channel|

        wrapper = Slack_Channel.new channel["name"], channel["id"] , purpose: channel["purpose"], is_archived: channel["is_archived"], members: channel["members"]
        channels << wrapper
      end
     return channels
    else
     return nil
    end
  end
>>>>>>> 4401558f78a7a72e9792f96177e63a30424a404a
end
