class Movie < ApplicationRecord
  has_many :movie_cinemas
  has_many :schedules
  has_many :rankings

  validates :name, uniqueness: true
end
