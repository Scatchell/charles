class DaysController < ApplicationController
  include DaysHelper
  protect_from_forgery except: :create_or_update, with: :exception
  before_action :authenticate_user!, except: :create_or_update

  def create_or_update
    end_time_from_post = seconds_to_time(params[:end_time]).in_time_zone(DaysHelper::get_time_zone_from(params[:gmt_offset]))
    user_auth_code_from_post = params[:user_auth]

    Day.create_or_update_date end_time_from_post, user_auth_code_from_post

    render nothing: true
  end

  def list
    days = current_user.days.order(start_time: :desc)
    @weeks = sort_by_weeks(days)
    @total_days = @weeks.flatten.size
  end

  def edit
    set_day
  end

  def update
    set_day

    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to root_path, notice: 'Day successfully updated!' }
      else
        format.html { redirect_to root_path, notice: 'Something went wrong - day was not updated' }
      end
    end

  end

  private
  def seconds_to_time seconds
    Time.at(seconds.to_i)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_day
    @day = Day.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def day_params
    params[:day].permit(:start_time, :end_time)
  end
end
