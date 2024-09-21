class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0 # 0 for receptionist, 1 for doctor
  end
end
