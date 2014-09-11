class DaysController < ApplicationController
  protect_from_forgery except: :create_or_update, with: :exception
  before_action :authenticate_user!, except: :create_or_update

  def create_or_update
    end_time_from_post = seconds_to_time(params[:end_time])
    user_auth_code_from_post = params[:user_auth]

    Day.create_or_update_date end_time_from_post, user_auth_code_from_post

    render nothing: true
  end

  def list
    @days = current_user.days.order(start_time: :desc)
  end

  private
  def seconds_to_time seconds
    Time.at(seconds.to_i)
  end
end
