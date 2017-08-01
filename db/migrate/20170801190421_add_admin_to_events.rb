class AddAdminToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :admin_id, :integer
  end
end
