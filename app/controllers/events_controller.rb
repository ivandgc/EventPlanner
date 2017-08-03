class EventsController < ApplicationController
  before_action :set_user, only: [:create]

  def new
    @event = Event.new
    @occasion = Occasion.find(params[:occasion_id])
  end

  def create
    @event = Event.new(event_params)
    @term = Term.find_or_create_by(term_params)
    @occasion = Occasion.find(params[:occasion_id])
    @event.term = @term
    @event.occasion = @occasion
    @event.admin = @user
    if @event.save
      redirect_to occasion_event_path(@occasion, @event)
    else
      flash[:message] = "Enter valid information"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @term = Term.find_or_create_by(term_params)
    @event.term = @term
    if @event.update(event_params)
      redirect_to occasion_event_path(@event.occasion, @event)
    else
      flash[:message] = "Enter correct data"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @occasion = @event.occasion
    @event.destroy
    redirect_to occasion_path(@occasion)
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :duration)
  end


  def term_params
    params.require(:event).require(:term).permit(:start_term, :end_term)
  end

end
