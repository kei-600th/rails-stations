class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.date :date
      t.references :movie, null: false, foreign_key: true
      t.integer :reservation_count

      t.timestamps
    end
  end
end
