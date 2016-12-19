class PaymentsController < ApplicationController
before_action :set_reservation

  def new
  end

  def create
    customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @reservation.amount_cents, # or amount_pennies
    description:  "Payment for flat #{@reservation.flat_title} for reservation #{@reservation.id}",
    currency:     @reservation.amount.currency
  )

  @reservation.update(payment: charge.to_json, state: 'paid')
  redirect_to reservation_path(@reservation)

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_reservation_payment_path(@reservation)
  end

  private

  def set_reservation
    @reservation = Reservation.where(state: 'pending').find(params[:reservation_id])
  end

end
