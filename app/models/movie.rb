class Movie < ApplicationRecord
  has_many :movie_cinemas
  has_many :schedules
  validates :name, uniqueness: true
end
