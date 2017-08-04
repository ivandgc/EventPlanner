class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]
  before_action :set_occasion_check_user, only: [:new, :create]
  before_action :event_admin?, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    term = Term.find_or_create_by(term_params)
    @event.term = term
    @event.occasion = @occasion
    @event.admin = @user
    if @event.save
      redirect_to occasion_event_path(@occasion, @event)
    else
      flash[:message] = @event.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    term = Term.find_or_create_by(term_params)
    @event.term = term
    if @event.update(event_params)
      redirect_to occasion_event_path(@event.occasion, @event)
    else
      flash[:message] = @event.errors.full_messages
      render :edit
    end
  end

  def destroy
    occasion = @event.occasion
    @event.destroy
    redirect_to occasion_path(occasion)
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :duration)
  end

  def term_params
    params.require(:event).require(:term).permit(:start_term, :end_term)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_admin?
    redirect_to root_path if @event.admin.id != current_user
  end

end
