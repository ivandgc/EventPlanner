class SessionsController < ApplicationController
  skip_before_action :verify_user, only: [:create]

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
    else
      flash[:message] = "Your E-mail or Password is invalid"
    end
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
