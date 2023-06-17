class Ranking < ApplicationRecord
  belongs_to :movie

  validates_uniqueness_of :date, scope: [:movie_id]

  def self.dayly_totalling
    # 今日の日付と30日前の日付を取得
    today = Date.today
    thirty_days_ago = today - 30.days

    # 今日の日付に一致する予約を抽出し、それらを映画ごとにグループ化し、予約数をカウント
    reservation_counts = Reservation.joins(schedule: { movie_cinema: :movie })
                                    .where(date: thirty_days_ago..today)
                                    .group('movies.id')
                                    .count

    # 上の結果はハッシュとして返され、キーは映画のID、値はその映画の予約数となる。

    # それぞれの映画について、新しい ranking レコードを作成
    reservation_counts.each do |movie_id, count|
      ranking = Ranking.new(date: today, movie_id: movie_id, reservation_count: count)
      if ranking.valid?
        ranking.save
      else
        Rails.logger.info("Failed to save ranking for movie_id #{movie_id} on #{today}: #{ranking.errors.full_messages.join(', ')}")
      end
    end
  end
end
