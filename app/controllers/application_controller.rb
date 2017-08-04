class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :username, :set_user
  before_action :verify_user


  def current_user
    session[:user_id] ||= nil
  end

  def logged_in?
    !!current_user
  end

  def username
    session[:username] ||= nil
    session[:username] ||= User.find(current_user).name.capitalize
  end

  def verify_user
     redirect_to root_path if !logged_in?
  end

  def set_user
    @user = User.find(current_user) if logged_in?
  end

  def set_occasion_check_user
    @occasion = Occasion.find(params[:occasion_id])
    redirect_to occasions_path if @occasion.users.find {|u| u.id == current_user} == nil
  end

end
