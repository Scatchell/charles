class Day < ActiveRecord::Base
  def time_worked
    minutes = ((end_time - start_time)/60)
    (minutes/60).round(2)
  end

  def self.day_for_date(time)
    all.select do |day|
      day.start_time.to_date == time.to_date
    end.first
  end

  def self.create_or_update_date(end_time_from_post)
    day_to_change = day_for_date end_time_from_post

    if day_to_change
      day_to_change.end_time = end_time_from_post
      day_to_change.save
    else
      @day = Day.create(start_time: Time.now, end_time: end_time_from_post)
    end
  end
end
