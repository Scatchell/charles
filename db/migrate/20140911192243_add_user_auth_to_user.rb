class AddUserAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_auth, :string, null: false, default: ''
  end
end
