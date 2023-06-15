class Screen < ApplicationRecord
  has_many :screen_sheets
  has_many :sheets, through: :screen_sheets
end