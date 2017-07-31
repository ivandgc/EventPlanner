class CreateUserOccasions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_occasions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :occasion, foreign_key: true

      t.timestamps
    end
  end
end
