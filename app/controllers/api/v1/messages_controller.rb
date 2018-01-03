class Api::V1::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @conversation = Conversation.find(message_params[:conversation_id])
    if @message.save()
      ActionCable.server.broadcast(@conversation, {message: @message})
    #   render json: @message
    # else
    #   render json: {error: "Something went wrong while creating the message"}, status: 400
    end
  end

  private
  
  def message_params
    params.permit(:conversation_id, :user_id, :text)
  end

end
