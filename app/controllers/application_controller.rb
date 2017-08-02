class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :occasion_admin?, :logged_in?, :username

  def current_user
    session[:user_id] ||= nil
  end

  def occasion_admin?
    @occasion = Occasion.find(params[:occasion_id])
    @occasion.admin.id == current_user
  end

  def logged_in?
    !!current_user
  end

  def username
    session[:username] ||= nil
    session[:username] ||= User.find(current_user).name.capitalize
  end

end
