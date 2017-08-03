require 'byebug'

class OccasionsController < ApplicationController
  helper_method :group_events

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
    @occasion = Occasion.find(params[:occasion_id])
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
    @occasion = Occasion.find(params[:occasion_id])
    @user_occasion = UserOccasion.create(user: @user, occasion: @occasion)
    flash[:message] = "#{@user.name.capitalize} Added to #{@occasion.title}"
    redirect_to occasion_path(@occasion)
  end


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
      groups << temp #unless temp.count == 1
    end
    groups
  end

  def vote
    @event = Event.find(params[:id])
    @user = User.find(current_user)
    @occasion = @event.occasion
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

  def occasion_params
    params.require(:occasion).permit(:title)
  end

  def term_params
    params.require(:occasion).require(:term).permit(:start_term, :end_term)
  end

  def sorted_events
    Occasion.find(params[:occasion_id]).events.sort_by {|e| e.term.start_term}
  end

end
