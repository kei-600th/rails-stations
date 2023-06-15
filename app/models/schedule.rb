class Schedule < ApplicationRecord
  belongs_to :movie_cinema
  has_many :reservations
end
