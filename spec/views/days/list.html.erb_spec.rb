require 'rails_helper'

RSpec.describe "days/list.html.erb", :type => :view do
  it 'should render list' do
    start_time = Time.at(1388556000)

    assign(:weeks, [[create(:day, start_time: start_time, end_time: start_time + 1000)]])

    render

    rendered.should include('Date: Tuesday -- 12/31/2013')
    rendered.should include('Start time for this day:')
    rendered.should include('22:00')
    rendered.should include('Latest ended time:')
    rendered.should include('22:16')
  end
end
