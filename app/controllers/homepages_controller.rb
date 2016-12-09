<<<<<<< HEAD
#require "slack_api_wrapper"
#require "channel"
=======
require "#{Rails.root}/lib/slack_api_wrapper.rb"
require "#{Rails.root}/lib/channel.rb"
>>>>>>> 4401558f78a7a72e9792f96177e63a30424a404a



class HomepagesController < ApplicationController
  def index
<<<<<<< HEAD
    @data = Slack_Api_Wrapper.list_channels
  end

  def create
    # raise
    response = Slack_Api_Wrapper.send_message(params["channel"], params["message"])

    if response["ok"]
      flash[:notice] = "Your message was sent to #{params["channel_name"]}!"
    else
      flash[:notice] = "Your message was NOT sent to #{params["channel_name"]}."
    end
    redirect_to root_path
  end

  def new
    @channel = params[:name]
    @channel_id = params[:id]
  end
=======
    @data = SlackApiWrapper.listchannels
    if @data != nil && @data != []
      render status: :created
    else
      render status: :service_unavailable
    end
  end

  def new
    @channel = params[:channel]
    @channel_id = params[:id]
  end

  def create
    result = SlackApiWrapper.sendmsg(params["channel"], params["message"])
    if result["ok"]
      flash[:notice] = "Message Sent"
    else
      flash[:notice] = "Message Failed to Send #{results['ok']}"
    end
    redirect_to :root
  end
>>>>>>> 4401558f78a7a72e9792f96177e63a30424a404a
end
