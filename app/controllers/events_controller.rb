class EventsController < ApplicationController

  before_action :find_event, only: [:edit,:show, :update,:destroy]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path, notice: 'Event Created'
    else
      render 'new'
      flash.now[:notice] = "erer"
    end
  end



  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to root_path, notice: 'Change Saved'
    else
      reder 'edit'
    end
  end

  def show
  end

  def destroy

  end

  private
  
  def event_params
    params.require(:event).permit(:title,:body,:start_date,:end_date)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end
