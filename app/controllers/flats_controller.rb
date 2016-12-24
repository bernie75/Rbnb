class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    # @flats = Flat.all
    @flats = Flat.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@flats) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def top
    @top_flats = Flat.where(stars: 3)
  end

  def new
    @flat = Flat.new
  end

  def show
    @review = @flat.reviews.new
    @flat_coordinates = { lat: @flat.latitude, lng: @flat.longitude }
    @hash = Gmaps4rails.build_markers(@flat) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
    end
  end

  def create
    @flat = current_user.flats.new(flat_params)
    if @flat.save
        redirect_to @flat
        else
        render :new

    end
  end


  def update
    if @flat.update(flat_params)
      redirect_to @flat
    else
      render :edit
    end
  end

  def edit

  end

  def destroy
    @flat.destroy
    respond_to do |format|
      format.html { redirect_to flats_url, notice: 'Flat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      params.require(:flat).permit(:title, :address, :description, :price, :stars, :latitude, :longitude, photos: [])
    end
end
