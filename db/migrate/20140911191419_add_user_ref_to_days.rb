class AddUserRefToDays < ActiveRecord::Migration
  def change
    add_reference :days, :user, index: true
  end
end
