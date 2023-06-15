class MovieCinema < ApplicationRecord
  belongs_to :movie
  belongs_to :cinema

  validates_uniqueness_of :movie_id, scope: :cinema_id, message: 'その組み合わせはすでに追加済みです'
end
