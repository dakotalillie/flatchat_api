class Api::V1::ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]
  # skip_before_action :authorized, only: [:view]
  
  def index
    @user = User.find(params[:id])
    @conversations = @user.conversations
    render json: @conversations, user_id: @user.id
  end
  
  def show
    render json: @conversation.messages
  end

  def view
    @user_conversation = UserConversation.find_by(
      user_id: params[:user_id],
      conversation_id: params[:conversation_id]
    )
    @user_conversation.updated_at = DateTime.now
    if @user_conversation.save()
      render json: {
        user_id: @user_conversation.user_id,
        conversation_id: @user_conversation.conversation_id,
        last_viewed: @user_conversation.updated_at
      }
    else
      render json: {error: "Something went wrong while viewing the conversation"}, status: 400
    end
  end
  
  def create
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      render :new
    end
  end
  
  def update
    if @conversation.update(conversation_params)
      redirect_to conversation_path(@conversation)
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
  
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
  
  def conversation_params
    params.require(:conversation).permit(:title)
  end

end
