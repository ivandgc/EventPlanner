class CreateUserEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :user_events do |t|
      t.belongs_to :user_occasion, on_delete: :cascade
      t.belongs_to :event, on_delete: :cascade
    end
  end
end
