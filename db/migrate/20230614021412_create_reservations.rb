class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|

      t.date :date, null: false
      t.references :schedule, null: false, foreign_key: true
      t.references :screen_sheet, null: false, foreign_key: true
      t.string :email, limit: 255, null: false, comment: '予約者メールアドレス'
      t.string :name, limit: 50, null: false, comment: '予約者名'

      t.timestamps
    end
  end
end
