class StaticController < ApplicationController
  skip_before_action :verify_user
  before_action :set_user, only: [:index]

  def index
    redirect_to occasions_path if logged_in?
  end
end
