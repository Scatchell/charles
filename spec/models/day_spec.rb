require 'rails_helper'

RSpec.describe Day, :type => :model do
  it 'should know how many hours were worked in a day' do
    day = Day.new(start_time: Time.now, end_time: Time.now + 18000)

    day.time_worked.should == 5
  end

  it 'should know that a certain date doesnt already exists' do
    created_day = create(:day, start_time: Time.new(2014, 2, 1, 1, 1, 1), end_time: Time.new(2014, 2, 1, 10, 10, 10))

    time = Time.new(2014, 1, 1, 1, 1, 1)
    Day.day_for_date(time).should be_nil
  end

  it 'should know that a certain date already exists' do
    start_time = Time.new(2014, 1, 1, 1, 1, 1)
    end_time = Time.new(2014, 1, 1, 10, 10, 10)
    created_day = create(:day, start_time: start_time, end_time: end_time)

    Day.day_for_date(end_time).should == created_day
  end

#   todo specs for decimal times
end
