class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy, :owner]

  def index
    @flats = Flat.all
  end

  def new
    @flat = Flat.new
  end

  def show
    @flat_coordinates = { lat: @flat.latitude, lng: @flat.longitude }
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.save
    # Unless @restaurant.valid?, #save will return false,
    # and @restaurant is not persisted.
    # TODO: present the form again with error messages.
    redirect_to flat_path(@flat)
  end

  def update
    if @flat.update(flat_params)
      redirect_to @flat
    else
      render :edit
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      params.require(:flat).permit(:title, :address, :description, :stars, :user_id, :latitude, :longitude)
    end
end
