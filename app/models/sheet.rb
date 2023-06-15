class Sheet < ApplicationRecord
  has_many :screen_sheets
  has_many :screens, through: :screen_sheets
end