class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  before_action :authorize_request! , only: [:create, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = @current_user.events.build(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @current_user.events.find(@event.id) && @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end

    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Unauthorized.' }, status: :unauthorized
  end

  # DELETE /events/1
  def destroy
    if @current_user.events.find(@event.id)
      @event.destroy
      render json: @event
    end

    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Unauthorized.' }, status: :unauthorized
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:name, :description, :date, :venue)
    end
end
