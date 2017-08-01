class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.time :duration
      t.belongs_to :occasion, on_delete: :cascade
      t.belongs_to :term, on_delete: :cascade

      t.timestamps
    end
  end
end
