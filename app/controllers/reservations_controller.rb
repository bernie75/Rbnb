class ReservationsController < ApplicationController
  def create
    @flat = Flat.find(params[:flat_id])
    reservation  = Reservation.create!(amount: @flat.price, state: 'pending')

    redirect_to new_reservation_payment_path(reservation)
  end
  def show
    @reservation = Reservation.where(state: 'paid').find(params[:id])
  end
end
