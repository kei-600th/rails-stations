class CreateCinemas < ActiveRecord::Migration[6.1]
  def change
    create_table :cinemas do |t|
      t.string :name, limit: 50, null: false, comment: '映画館名'
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
