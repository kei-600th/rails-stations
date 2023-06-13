class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet

  validates_uniqueness_of :schedule_id, scope: [:sheet_id, :date], message: 'そのスケジュール、シート、日付の組み合わせはすでに予約済みです'
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'メールアドレスの形式が不正です'
end
