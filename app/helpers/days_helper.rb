module DaysHelper
  def sort_by_weeks(days)
    weeks = group_weeks(days)

    weeks.sort_by do |_, week|
      week.first.start_time
    end

    weeks.collect do |week|
      week[1]
    end
  end

  def group_weeks(days)
    days.group_by do |day|
      day.start_time.strftime('%Y-%W')
    end
  end

  def different
    weeks.each do |week|
      first_day_of_week = beg_of_week week[0].start_time
      last_day_of_week = end_of_week week[0].start_time

      puts 'Week: ' + first_day_of_week.strftime('%A') + ', ' + first_day_of_week.month.to_s + '/' + first_day_of_week.day.to_s + " - " + last_day_of_week.month.to_s + '/' + last_day_of_week.day.to_s
      week.each do |day|
        puts day.start_time.strftime('%A') + ', ' + day.start_time.month.to_s + '/' + day.start_time.day.to_s + ': ' + day.time_worked.to_s
      end
    end
  end

  def beg_of_week first_day_start_time
    first_day_start_time - first_day_start_time.wday * (24*60*60)
  end

  def end_of_week first_day_start_time
    beg_of_week(first_day_start_time) + (7*24*60*60)
  end

  def self.get_time_zone_from(offset)
    ActiveSupport::TimeZone[offset.to_i].name
  end

end
