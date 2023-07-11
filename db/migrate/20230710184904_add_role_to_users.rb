class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :string, default: 'sender'

    User.reset_column_information
    User.update_all(role: 'sender')
  end
end
