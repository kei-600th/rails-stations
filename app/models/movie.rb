class Movie < ApplicationRecord
  has_many :movie_cinemas
  has_many :schedules
  has_many :rankings
  has_many :reviews

  validates :name, uniqueness: true
end
