class DaysController < ApplicationController
  protect_from_forgery except: :create_or_update, with: :exception

  def create_or_update
    end_time_from_post = seconds_to_time(params[:end_time])

    Day.create_or_update_date end_time_from_post

    render nothing: true
  end

  def list
    @days = Day.order(start_time: :desc)
  end

  private
  def seconds_to_time seconds
    Time.at(seconds.to_i)
  end
end
