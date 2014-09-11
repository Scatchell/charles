FactoryGirl.define do
  factory :day do
    start_time Time.now
    end_time Time.now
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    password 'password'
  end
end