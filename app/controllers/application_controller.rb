class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :occasion_admin?

  def current_user
    session[:user_id] ||= nil
  end

  def occasion_admin?
    @occasion = Occasion.find(params[:id])
    @occasion.admin.id == current_user
  end

end
