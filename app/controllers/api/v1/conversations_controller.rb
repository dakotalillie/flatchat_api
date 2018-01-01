class Api::V1::ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]
  
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
    @conversation = Conversation.new()
    users = conversation_params[:users].map do |user_id|
      User.find(user_id)
    end
    users.each do |user|
      @conversation.users.push(user)
    end
    if @conversation.save
      render json: @conversation
    else
      render json: {
        error: "Something went wrong creating a new conversation"
      }, error: 400
    end
  end

  def remove_user
    @conversation = Conversation.find(params[:conversation_id])
    @user = User.find(params[:user_id])
    if @conversation.users.delete(@user)
      render json: {
        message: "User successfully removed from conversation",
        user_id: @user.id,
        conversation_id: @conversation.id
      }
    else
      render json: {
        error: "Something went wrong removing a user from a conversation"
      }, error: 400
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
    params.permit(users: [])
  end

end
