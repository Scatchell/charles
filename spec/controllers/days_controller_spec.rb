require 'rails_helper'

RSpec.describe DaysController, :type => :controller do

  describe 'Days basic functionality' do
    it 'Should create a day if it doesnt exist' do
      expect {
        post :create_or_update, {end_time: 1388556000}
      }.to change(Day, :count).by(1)
    end

    it 'Should update a day if it does exist' do
      time = Time.new(2014)
      day = create(:day, start_time: time, end_time: time + 1000)

      post :create_or_update, {end_time: 1388558000}

      updated_day = Day.find(day.id)
      updated_day.end_time.to_i.should == 1388558000
      expect(response).to be_success
    end

    it 'List all days' do
      days_created = create_list(:day, 3)
      get :list
      assigns(:days).should == days_created
      response.should be_success
    end


    # it "returns http success" do
    #   get :delete
    #   expect(response).to be_success
    # end
  end
end
