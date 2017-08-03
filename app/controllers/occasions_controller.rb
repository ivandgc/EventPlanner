require 'byebug'

class OccasionsController < ApplicationController
  helper_method :group_events
  before_action :set_user, only: [:index, :create, :vote]
  before_action :set_occasion, only: [:edit, :update, :destroy, :add_friend]
  before_action :set_occasion_check_user, only: [:show, :vote]
  before_action :occasion_admin?, only: [:edit, :update, :destroy, :add_friend]

  def index
  end

  def new
    @occasion = Occasion.new
  end

  def create
    @occasion = Occasion.new(occasion_params)
    @term = Term.find_or_create_by(term_params)
    @occasion.term = @term
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
  end

  def edit
  end

  def update
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
    @occasion.destroy
    redirect_to occasions_path
  end

  def add_friend
    @user = User.find_by(name: params[:search].downcase)
    @user_occasion = UserOccasion.create(user: @user, occasion: @occasion)
    flash[:message] = "#{@user.name.capitalize} Added to #{@occasion.title}"
    redirect_to occasion_path(@occasion)
  end



  def vote
    byebug
    @event = Event.find(params[:id])
    @user_occasion = UserOccasion.find_by(user: @user, occasion: @occasion)
    @conflicting_events = group_events.select {|e| e.include?(@event)}.flatten.uniq
    flag = 0
    @conflicting_events.each do |event|
      @vote = UserEvent.find_by(user_occasion: @user_occasion, event: event)
      if @vote.present?
        flag = 1
        break
      end
    end
    @vote = UserEvent.new(user_occasion: @user_occasion) if flag == 0
    @vote.event = @event
    flash[:message] = (@vote.save ? "Vote was recorded" : "Vote was not recorded")
    redirect_to occasion_path(@occasion)
  end

  private

  def group_events
    @sorted_events = sorted_events
    @event_count = @sorted_events.count - 1
    groups = []
    @sorted_events.each_with_index do |event, i|
      count = i + 1
      temp = [event]
      while count <= @event_count
        temp << @sorted_events[count] if event.term.end_term > @sorted_events[count].term.start_term
        count += 1
      end
      groups << temp unless temp.count == 1 &&  groups.flatten.find {|e| e == temp.first} != nil
    end
    groups
  end

  def occasion_params
    params.require(:occasion).permit(:title)
  end

  def term_params
    params.require(:occasion).require(:term).permit(:start_term, :end_term)
  end

  def sorted_events
    Occasion.find(params[:occasion_id]).events.sort_by {|e| e.term.start_term}
  end

  def set_occasion
    @occasion = Occasion.find(params[:id])
  end

  def set_occasion_check_user
    @occasion = Occasion.find(params[:occasion_id])
    redirect_to occasions_path if @occasion.users.find {|u| u.id == current_user} == nil
  end

  def occasion_admin?
    redirect_to occasion_path(@occasion) if @occasion.admin.id != current_user
  end

end
