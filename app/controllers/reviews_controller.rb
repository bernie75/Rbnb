class ReviewsController < ApplicationController
  before_action :find_flat, only: [ :new, :create, :destroy ]

  def new
    @review = @flat.reviews.build
  end

  def create
    @review = @flat.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      respond_to do |format|
        format.html { redirect_to flat_path(@flat) }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { render '/flats/show' }
        format.js  # <-- idem
      end
    end
  end
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to flat_path(@flat), notice: 'Flat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
  def find_flat
    @flat = Flat.find(params[:flat_id])
  end
end

