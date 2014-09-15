class AddTimeZoneToDay < ActiveRecord::Migration
  def change
    add_column :days, :time_zone, :string
  end
end
