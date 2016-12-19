class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy, :owner]

  def index
    @flats = Flat.all
    @flats = Flat.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@flats) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def new
    @flat = Flat.new
  end

  def show
    @flat_coordinates = { lat: @flat.latitude, lng: @flat.longitude }
    @hash = Gmaps4rails.build_markers(@flats) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
    end
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
        redirect_to @flat
        else
        render :new
      respond_to do |format|
        if @flat.save
          format.html { redirect_to @flat, notice: 'Flat was successfully created.' }
          format.json { render :show, status: :created, location: @flat }
        else
          format.html { render :new }
          format.json { render json: @flat.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def update
    if @flat.update(flat_params)
      redirect_to @flat
    else
      render :edit
    end
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
      params.require(:flat).permit(:title, :address, :description, :stars, :user_id, :latitude, :longitude)
    end
end
