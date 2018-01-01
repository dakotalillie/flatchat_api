class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authorized, only: [:search, :create]

  def search
    matches = User.where("username LIKE :query", query: "%#{params[:query]}%")
    results = matches.map do |match|
      {
        id: match.id,
        username: match.username,
        first_name: match.first_name,
        last_name: match.last_name
      }
    end
    if matches.first
      render json: results
    else
      render json: []
    end
  end
  
  def index
  end
  
  def show
    render json: @user
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        id: @user.id,
        username: @user.username, 
        first_name: @user.first_name,
        last_name: @user.last_name, 
        token: issue_token({id: @user.id})
      }
    else
      render({json: {error: 'Error while creating user'}, status: 401})
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.permit(:username, :first_name, :last_name, :password)
  end

end
