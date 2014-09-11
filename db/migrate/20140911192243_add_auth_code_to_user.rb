class AddUserAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :auth_code, :string, null: false, default: ''
  end
end
