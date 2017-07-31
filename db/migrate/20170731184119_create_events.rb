class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.time :duration
      t.belongs_to :occasion, foreign_key: true
      t.belongs_to :term, foreign_key: true

      t.timestamps
    end
  end
end
