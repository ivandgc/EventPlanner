class UsersController < ApplicationController
  skip_before_action :verify_user, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.name = @user.name.downcase
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Please enter valid information"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    @user.name = @user.name.downcase
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:message] = "Please enter valid information"
      render :edit
    end
  end

  def destroy
    @user.destroy
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(current_user)
  end

end
