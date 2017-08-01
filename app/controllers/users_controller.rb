class UsersController < ApplicationController

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
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
