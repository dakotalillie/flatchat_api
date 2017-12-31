class Api::V1::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    if @message.save()
      render json: @message
    else
      render json: {error: "Something went wrong while creating the message"}, status: 400
    end
  end

  private
  
  def message_params
    params.permit(:conversation_id, :user_id, :text)
  end

end
