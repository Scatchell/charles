require 'rails_helper'

RSpec.describe Day, :type => :model do
  it 'should know how many hours were worked in a day' do
    day = Day.new(start_time: Time.now, end_time: Time.now + 18000)

    day.time_worked.should == 5
  end

  it 'should know that a certain date does not already exists' do
    user = create(:user)
    create(:day, start_time: Time.new(2014, 2, 1, 1, 1, 1), end_time: Time.new(2014, 2, 1, 10, 10, 10), user: user)


    time = Time.new(2014, 1, 1, 1, 1, 1)
    Day.day_for_date(time, user).should be_nil
  end

  it 'should know that a certain date already exists' do
    start_time = Time.new(2014, 1, 1, 1, 1, 1)
    end_time = Time.new(2014, 1, 1, 10, 10, 10).in_time_zone('Etc/UTC')
    user = create(:user)
    created_day = create(:day, start_time: start_time, end_time: end_time, time_zone: 'Etc/UTC', user: user)

    Day.day_for_date(end_time, user).should == created_day
  end

  it 'should know start time in correct time zone' do
    time = '2016-08-15 09:00'.to_time.in_time_zone('UTC')
    later_time = '2016-08-15 17:00'.to_time.in_time_zone('UTC')
    user = create(:user)
    puts time.gmt_offset
    time_zone = DaysHelper.get_time_zone_from(time.gmt_offset)
    puts time_zone
    day = create(:day, start_time: time, end_time: later_time, time_zone: time_zone, user: user)

    day.start_time.to_s.should == '2016-08-15 09:00:00 +0100'
  end

#   todo specs for decimal times
end
