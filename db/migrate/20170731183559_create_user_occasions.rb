class CreateUserOccasions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_occasions do |t|
      t.belongs_to :user, on_delete: :cascade
      t.belongs_to :occasion, on_delete: :cascade

      t.timestamps
    end
  end
end
