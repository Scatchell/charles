class Day < ActiveRecord::Base
  include DaysHelper

  belongs_to :user

  def time_worked
    minutes = ((end_time - start_time)/60)
    (minutes/60).round(2)
  end

  def self.day_for_date(time, user)
    user.days.select do |day|
      day.start_time.to_date == time.to_date
    end.first
  end

  def self.create_or_update_date(end_time, user_auth_code)
    user = User.find_by_auth_code(user_auth_code)

    if user
      day_to_change = day_for_date end_time, user

      if day_to_change
        day_to_change.end_time = end_time
        day_to_change.save
      else
        time_zone = DaysHelper::get_time_zone_from(end_time.gmt_offset)
        @day = Day.create(start_time: end_time, end_time: end_time, time_zone: time_zone, user: user)
      end
    end
  end

  def start_time
    user_time_zone read_attribute(:start_time)
  end

  def end_time
    user_time_zone read_attribute(:end_time)
  end

  private

  def user_time_zone(time)
    time.in_time_zone(self.time_zone)
  end
end
