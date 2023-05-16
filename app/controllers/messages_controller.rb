class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel" #記述箇所
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

class MessagesController < ApplicationController
  def new
    @messages = Message.all
    @message = Message.new
  end

  def create
    @message = Message.new(text: params[:message][:text])
    if @message.save
      ActionCable.server.broadcast 'message_channel', {content: @message}
    end
  end
end
  