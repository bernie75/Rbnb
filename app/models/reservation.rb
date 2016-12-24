class Reservation < ApplicationRecord
 belongs_to :user, required: true
 belongs_to :flat, required: true

 monetize :amount_cents
end
