require 'byebug'

class OccasionsController < ApplicationController

  def index
    @user = User.find(current_user)
  end

  def new
    @occasion = Occasion.new
  end

  def create
    @occasion = Occasion.new(occasion_params)
    @term = Term.find_or_create_by(term_params)
    @occasion.term = @term
    @user = User.find(current_user)
    byebug
    @occasion.admin = @user
    if @occasion.save
      @user_occasions = UserOccasion.create(user: @user, occasion: @occasion)
      redirect_to occasion_path(@occasion)
    else
      flash[:message] = "Invalid input"
      render :new
    end
  end

  def show
    @occasion = Occasion.find(params[:id])
  end

  def edit
    @occasion = Occasion.find(params[:id])
  end

  def update
    @occasion = Occasion.find(params[:id])
    @term = Term.find_or_create_by(term_params)
    @occasion.term = @term
    if @occasion.update(occasion_params)
      redirect_to occasion_path(@occasion)
    else
      flash[:message] = "Enter correct data"
      render :edit
    end
  end

  def destroy
    @occasion = Occasion.find(params[:id])
    @occasion.destroy
    redirect_to occasions_path
  end

  def add_friend
    @user = User.find_by(name: params[:search].downcase)
    @occasion = Occasion.find(params[:id])
    @user_occasion = UserOccasion.create(user: @user, occasion: @occasion)
    flash[:message] = "#{@user.name.capitalize} Added to #{@occasion.title}"
    redirect_to occasion_path(@occasion)
  end

  private

  def occasion_params
    params.require(:occasion).permit(:title)
  end

  def term_params
    params.require(:occasion).require(:term).permit(:start_term, :end_term)
  end

end
