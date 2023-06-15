class CreateMovieCinemas < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_cinemas do |t|
      t.references :movie, foreign_key: true
      t.references :cinema, foreign_key: true

      t.timestamps
    end
  end
end
