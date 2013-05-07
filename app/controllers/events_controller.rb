class EventsController < ApplicationController
  
before_filter :check_login
authorize_resource

  def index
    @events = Event.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def show
    #get info on one event
    @event = Event.find(params[:id])

  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully created #{@event.name}."
      redirect_to @event
    else
      render :action => 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated #{@event.name}."
      redirect_to @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:notice] = "Successfully destroyed #{@event.name}."
      redirect_to events_url
    else
      flash[:warning] = "Cannot destroy #{@event.name} because it has students assigned."
      redirect_to @event
    end

  end

  #Custom views

  def active
    @active_events = Event.active.alphabetical.paginate(:page => params[:page]).per_page(20)
  end

  def inactive
    @inactive_events = Event.inactive.alphabetical.paginate(:page => params[:page]).per_page(20)
  end


end