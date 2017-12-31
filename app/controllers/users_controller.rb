class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
  end
  
  def show
    render json: @user
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
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
    params.require(:user).permit(:username, :first_name, :last_name)
  end

end
