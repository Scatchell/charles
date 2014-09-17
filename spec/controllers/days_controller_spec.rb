require 'rails_helper'

RSpec.describe DaysController, :type => :controller do

  describe 'Days basic functionality' do
    after(:each) do
      expect(response).to be_success
    end

    it 'Should create a day if it doesnt exist' do
      user = create(:user, auth_code: '12345')

      expect {
        post :create_or_update, {user_auth: '12345', end_time: '1388556000', gmt_offset: '-25200'}
      }.to change(Day, :count).by(1)

      Day.last.user_id.should == user.id
    end

    it 'Should create a day with the correct timezone' do
      create(:user, auth_code: '12345')

      initial_time_string = Time.at(1388556000)

      athens_gmt_offset = Time.at(1388556000).in_time_zone('Europe/Athens').gmt_offset.to_s

      expect {
        post :create_or_update, {user_auth: '12345', end_time: '1388556000', gmt_offset: athens_gmt_offset}
      }.to change(Day, :count).by(1)

      # using to_s compares the time zone's as well as the full date and time
      Day.last.end_time.to_s.should == initial_time_string.in_time_zone('Europe/Athens').to_s
    end

    it 'Should update a day if it does exist for the given user auth' do
      time = Time.new(2014).in_time_zone('Etc/UTC')

      day = create(:day, start_time: time, end_time: time + 1000, time_zone: 'Etc/UTC')
      create(:user, auth_code: '12345', days: [day])
      old_ending_time = day.end_time.to_i.to_s

      new_ending_time = (old_ending_time.to_i + 1000).to_s
      post :create_or_update, {user_auth: '12345', end_time: new_ending_time, gmt_offset: 0}

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

    it 'List all days in descending order' do
      user = create(:user)
      sign_in user

      time = Time.at(1388556000)

      earliest_day = create(:day, start_time: time, end_time: time + 1000, user: user)
      latest_day = create(:day, start_time: time + 2000, end_time: time + 3000, user: user)
      middle_day = create(:day, start_time: time + 1000, end_time: time + 2000, user: user)
      get :list

      assigns(:days).to_a.should == [latest_day, middle_day, earliest_day]
    end

    # todo enable deletion of days sometime
    # it "returns http success" do
    #   get :delete
    #   expect(response).to be_success
    # end
    private
    def get_time_zone time
      time.strftime('%z')
    end
  end

  describe 'update existing days' do
    it 'should update an existing day' do
      user = create(:user)
      sign_in user

      time = Time.at(1388556000)
      new_start_time = Time.at(1388556000) + 1000
      created_day = create(:day, start_time: time, end_time: time + 1000, user: user)

      # Day.any_instance.should_receive(:update).with({'start_time' => new_start_time})
      put :update, {:id => created_day.to_param, :day => {'start_time' => new_start_time}}, {}
      newly_updated_day = Day.find(created_day.id)
      newly_updated_day.start_time.should == new_start_time

      expect(response).to redirect_to root_path
    end
  end
end
