require 'rails_helper'

RSpec.describe DaysController, :type => :controller do

  describe 'Days basic functionality' do
    after(:each) do
      expect(response).to be_success
    end
    it 'Should create a day if it doesnt exist' do
      user = create(:user, auth_code: '12345')

      expect {
        post :create_or_update, {user_auth: '12345', end_time: '1388556000'}
      }.to change(Day, :count).by(1)

      Day.last.user_id.should == user.id
    end

    it 'Should update a day if it does exist for the given user auth' do
      time = Time.new(2014)

      day = create(:day, start_time: time, end_time: time + 1000)
      create(:user, auth_code: '12345', days: [day])
      old_ending_time = day.end_time.to_i.to_s

      new_ending_time = (old_ending_time.to_i + 1000).to_s
      post :create_or_update, {user_auth: '12345', end_time: new_ending_time}

      updated_day = Day.find(day.id)
      updated_day.end_time.to_i.should == new_ending_time.to_i
    end

    it 'Should not update a day for wrong user, instead create a new day' do
      time = Time.new(2014)

      day_for_incorrect_user = create(:day, start_time: time, end_time: time + 1000)
      old_ending_time = day_for_incorrect_user.end_time.to_i

      incorrect_user_auth_code = '99999'
      create(:user, auth_code: incorrect_user_auth_code, days: [day_for_incorrect_user])
      correct_user_auth_code = '12345'
      create(:user, auth_code: correct_user_auth_code)

      expect {
        new_ending_time = old_ending_time + 1000
        post :create_or_update, {user_auth: correct_user_auth_code, end_time: new_ending_time}
      }.to change(Day, :count).by(1)

      updated_day = Day.find(day_for_incorrect_user.id)
      updated_day.end_time.to_i.should == old_ending_time
    end

    it 'Should not create a day if no user for auth code exists' do
      Time.new(2014)

      expect {
        post :create_or_update, {user_auth: '12345', end_time: 1388558000}
      }.to change(Day, :count).by(0)
    end

    it 'List all days' do
      user = create(:user)
      sign_in user

      days_created = create_list(:day, 3, user: user)
      get :list
      assigns(:days).should == days_created
    end


    # todo enable deletion of days sometime
    # it "returns http success" do
    #   get :delete
    #   expect(response).to be_success
    # end
  end
end
