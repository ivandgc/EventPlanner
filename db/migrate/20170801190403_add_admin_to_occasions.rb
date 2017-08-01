class AddAdminToOccasions < ActiveRecord::Migration[5.1]
  def change
    add_column :occasions, :admin_id, :integer
  end
end
