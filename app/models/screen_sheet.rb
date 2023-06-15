class ScreenSheet < ApplicationRecord
  belongs_to :screen
  belongs_to :sheet
  has_many :reservations
end





