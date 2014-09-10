class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
