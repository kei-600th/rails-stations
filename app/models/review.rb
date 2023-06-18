class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :evaluation, presence: true
  validates :evaluation, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  validates_uniqueness_of :movie_id, scope: [:user_id], message: 'すでにこの映画にはレビューを投稿しています。'
end
