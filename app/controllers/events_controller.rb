class EventsController < ApplicationController
  before_action :authenticate_user, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @all_events = Event.all
  end

  def show
    @event = Event.find(params[:id].to_i)
  end 

  def new
    @event = Event.new
  end

  def create 
    @event = Event.new(
      title:event_params["title"],
      location:event_params["location"],
      price:event_params["price"],
      duration:event_params["duration"],
      start_date:event_params["start_date"],
      description:event_params["description"])
    @event.admin_id = current_user.id

    if @event.save 
      redirect_to events_path(success_event_create:true) 
    else
      render 'new' 
    end
  end 

  def edit 
    @event = Event.find(params[:id])
  end 

  def update
    @event = Event.find(params[:id])

    # A REVOIR
    #if @event.update(title:params[:title],content:params[:content]) 
    #  redirect_to gossip_path(params[:id], success_gossip_update:true) 
    #else
    #  render 'edit' 
    #end
  end 

  def destroy
    @event = Event.find(params[:id])

    if @event.delete
      redirect_to events_path(success_event_delete:true) 
    end
  end 

  private
    def event_params
      params.require(:event).permit(:title, :description, :location, :duration, :price, :start_date)
    end

    def authenticate_user
      unless current_user
        redirect_to user_session_path(connexion_obligatoire:true)
      end
    end
end
