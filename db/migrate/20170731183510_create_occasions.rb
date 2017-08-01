class CreateOccasions < ActiveRecord::Migration[5.1]
  def change
    create_table :occasions do |t|
      t.string :title
      t.belongs_to :term, on_delete: :cascade

      t.timestamps
    end
  end
end
