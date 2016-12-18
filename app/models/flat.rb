class Flat < ApplicationRecord
  #belongs_to :user
  monetize :price_cents
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
