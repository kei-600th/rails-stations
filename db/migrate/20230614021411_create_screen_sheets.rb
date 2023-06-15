class CreateScreenSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :screen_sheets do |t|
      t.references :screen, foreign_key: true
      t.references :sheet, foreign_key: true

      t.timestamps
    end
  end
end
