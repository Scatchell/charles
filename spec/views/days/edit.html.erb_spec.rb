require 'rails_helper'

RSpec.describe 'days/edit.html.erb', :type => :view do
  it 'renders the edit day form' do
    start_time = Time.at(1388556000)

    assign(:day, create(:day, start_time: start_time, end_time: start_time + 1000))

    render

    rendered.should include('id="edit_day')
  end
end
