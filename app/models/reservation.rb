class Reservation < ApplicationRecord
   belongs_to :user
   belongs_to :flat
  monetize :amount_cents
end
