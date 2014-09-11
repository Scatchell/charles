module DaysHelper
  def display_days_by_week(weeks)
    # todo this code was grabbed from original charles and will need some tweaking
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

end