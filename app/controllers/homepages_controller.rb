#require "slack_api_wrapper"
#require "channel"



class HomepagesController < ApplicationController
  def index
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
end
