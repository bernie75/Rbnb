class Flat < ApplicationRecord

  belongs_to :user, required: true
  has_many :reservations
  has_attachments :photos, maximum: 3
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true

  monetize :price_cents

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
