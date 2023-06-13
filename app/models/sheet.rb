class Sheet < ApplicationRecord
  has_many :reservations
  belongs_to :screen
end